{
  modulesPath,
  pkgs,
  lib,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  networking.hostName = "nyx";
  nixpkgs.hostPlatform = "x86_64-linux";

  # ZFS Support
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.forceImportRoot = false;
  boot.zfs.forceImportAll = false;

  # Required for ZFS
  networking.hostId = "12345678"; # Must be 8 hex characters, can be random

  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      experimental-features = ["nix-command" "flakes"];
    };
  };

  environment.systemPackages = with pkgs; [
    git
    jq
    gum
    disko
    rsync
    networkmanager
    # ZFS utilities
    zfs
    (writeShellApplication {
      name = "welcome";
      text = ''
        #!/usr/bin/env bash
        echo "🏠 Welcome to NixOS Installer (nyx)"
        echo ""
        echo "Available tools:"
        echo "  📦 i                    - Interactive NixOS installer"
        echo "  🔧 nixos-enter-helper   - Mount & enter existing NixOS system"
        echo "  🌐 nmtui                - Connect to WiFi"
        echo "  📋 lsblk -f             - List partitions and filesystems"
        echo ""
        echo "Quick start: Run 'nmtui' to connect to WiFi, then 'i' to install NixOS"
      '';
    })
    (writeShellApplication {
      name = "i";
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        log() { printf "\033[1;34m[INFO]\033[0m %s\n" "$*"; }
        fail() { echo "$*" >&2; exit 1; }

        WORKDIR=/tmp/nixdots
        REPO_URL="https://github.com/xhos/nixdots.git"

        # Clone or update repository
        if [ -d "$WORKDIR/.git" ]; then
          log "Updating repo in $WORKDIR"
          git -C "$WORKDIR" fetch --prune --quiet
          git -C "$WORKDIR" reset --hard origin/HEAD --quiet
        else
          log "Cloning $REPO_URL"
          git clone --depth=1 "$REPO_URL" "$WORKDIR"
        fi

        # Select host
        HOST=$(nix flake show "$WORKDIR" --json \
                | jq -r '.nixosConfigurations | keys[]' \
                | gum choose --header "Select machine")
        [ -n "$HOST" ] || fail "No host selected"

        HOST_DIR="$WORKDIR/hosts/$HOST"
        [ -d "$HOST_DIR" ] || fail "Missing host directory: $HOST_DIR"

        # Select disk
        DISK=$(lsblk -dpno NAME,SIZE \
                | gum choose --header "Select target disk for \"$HOST\"" \
                | awk '{print $1}')
        [ -b "$DISK" ] || fail "Invalid disk selected"

        gum confirm "⚠️  This will WIPE $DISK. Continue?" || exit 1

        # Run disko
        CONFIG="$HOST_DIR/disko.nix"
        [ -f "$CONFIG" ] || fail "disko.nix missing"
        log "Running disko on $DISK"
        disko --mode zap_create_mount --argstr disk "$DISK" "$CONFIG"

        # Generate hardware config (always overwrite)
        log "Generating hardware-configuration.nix"
        nixos-generate-config --root /mnt --no-filesystems
        cp -f /mnt/etc/nixos/hardware-configuration.nix "$HOST_DIR/hardware-configuration.nix"

        # Sync repository into /mnt
        log "Syncing repo into /mnt/etc/nixos"
        rsync -a --delete "$WORKDIR/" /mnt/etc/nixos/

        # Install from path flake (works even if not committed)
        log "Installing NixOS for $HOST"
        nixos-install --root /mnt --flake "path:/mnt/etc/nixos#''${HOST}" --no-root-passwd

        echo "✅ Done. Reboot or run 'nixos-enter-helper' to enter the installed system."
      '';
    })

    (writeShellApplication {
      name = "nixos-enter-helper";
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        # Colors and formatting
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        YELLOW='\033[1;33m'
        BLUE='\033[0;34m'
        PURPLE='\033[0;35m'
        NC='\033[0m' # No Color

        fail() {
          echo -e "''${RED}❌ Error:''${NC} $*" >&2
          exit 1
        }

        info() {
          echo -e "''${BLUE}ℹ️ ''${NC} $*"
        }

        success() {
          echo -e "''${GREEN}✅''${NC} $*"
        }

        warn() {
          echo -e "''${YELLOW}⚠️ ''${NC} $*"
        }

        # Check if we're running as root
        if [[ $EUID -eq 0 ]]; then
          warn "Running as root. Be careful!"
        fi

        echo -e "''${PURPLE}🔧 NixOS Enter Helper''${NC}"
        echo "This tool helps you mount and enter an installed NixOS system for maintenance."
        echo ""

        # Show current mounts to avoid conflicts
        if mountpoint -q /mnt 2>/dev/null; then
          warn "/mnt is already mounted. Current mounts:"
          mount | grep "/mnt" || true
          echo ""
          if ! gum confirm "Continue anyway? (this might unmount existing mounts)"; then
            exit 0
          fi
        fi

        # Get partition information with details
        info "Scanning for partitions..."

        # Create a formatted list of partitions with details (avoid tree characters)
        partition_list=$(lsblk -lno NAME,SIZE,FSTYPE,MOUNTPOINT,LABEL | \
          grep -E "^[a-z]+[0-9]+" | \
          while read -r name size fstype mountpoint label _; do
            # Format display string with proper spacing
            display="$name"
            [[ -n "$size" ]] && display="$display ($size)"
            [[ -n "$fstype" ]] && display="$display [$fstype]"
            [[ -n "$label" ]] && display="$display {$label}"
            [[ -n "$mountpoint" ]] && display="$display -> $mountpoint"

            echo "/dev/$name|$display"
          done)

        if [[ -z "$partition_list" ]]; then
          fail "No partitions found. Make sure your disks are properly connected."
        fi

        echo ""
        info "Found partitions:"
        echo "$partition_list" | cut -d'|' -f2

        echo ""
        # Select root partition
        ROOT_DEVICE=$(echo "$partition_list" | gum choose --header "🗂️  Select ROOT partition (usually ext4, btrfs, or zfs):" | cut -d'|' -f1)
        [[ -n "$ROOT_DEVICE" ]] || fail "No root partition selected"

        # Get filesystem type for root
        ROOT_FSTYPE=$(lsblk -no FSTYPE "$ROOT_DEVICE" 2>/dev/null || echo "unknown")

        success "Selected root: $ROOT_DEVICE ($ROOT_FSTYPE)"

        # Select boot partition (EFI/boot)
        echo ""
        BOOT_DEVICE=$(echo "$partition_list" | gum choose --header "🥾 Select BOOT/EFI partition (usually vfat/fat32):" | cut -d'|' -f1)
        [[ -n "$BOOT_DEVICE" ]] || fail "No boot partition selected"

        # Get filesystem type for boot
        BOOT_FSTYPE=$(lsblk -no FSTYPE "$BOOT_DEVICE" 2>/dev/null || echo "unknown")

        success "Selected boot: $BOOT_DEVICE ($BOOT_FSTYPE)"

        echo ""
        # Final confirmation
        info "About to mount:"
        echo "  Root: $ROOT_DEVICE ($ROOT_FSTYPE) -> /mnt"
        echo "  Boot: $BOOT_DEVICE ($BOOT_FSTYPE) -> /mnt/boot"
        echo ""

        if ! gum confirm "Proceed with mounting and entering NixOS?"; then
          info "Aborted by user"
          exit 0
        fi

        echo ""
        info "Unmounting any existing /mnt mounts..."
        # Safely unmount existing mounts
        for mount in $(mount | grep "/mnt" | awk '{print $3}' | sort -r); do
          warn "Unmounting $mount"
          sudo umount -l "$mount" 2>/dev/null || true
        done

        # Special handling for ZFS
        if [[ "$ROOT_FSTYPE" == "zfs_member" ]]; then
          info "Detected ZFS filesystem. Importing ZFS pools..."

          # List available pools
          available_pools=$(sudo zpool import 2>/dev/null | grep "pool:" | awk '{print $2}' || echo "")

          if [[ -n "$available_pools" ]]; then
            POOL=$(echo "$available_pools" | gum choose --header "📦 Select ZFS pool to import:")
            [[ -n "$POOL" ]] || fail "No ZFS pool selected"

            info "Importing ZFS pool: $POOL"
            sudo zpool import -f "$POOL" || fail "Failed to import ZFS pool"

            # List datasets in the pool
            datasets=$(sudo zfs list -H -o name | grep "^$POOL" || echo "")
            if [[ -n "$datasets" ]]; then
              ROOT_DATASET=$(echo "$datasets" | gum choose --header "🗃️  Select root dataset:")
              [[ -n "$ROOT_DATASET" ]] || fail "No root dataset selected"

              info "Mounting ZFS dataset: $ROOT_DATASET"
              sudo zfs set mountpoint=/mnt "$ROOT_DATASET" || fail "Failed to set ZFS mountpoint"
              sudo zfs mount "$ROOT_DATASET" || fail "Failed to mount ZFS dataset"
            else
              fail "No datasets found in pool $POOL"
            fi
          else
            # Try mounting directly
            info "Mounting root partition..."
            sudo mkdir -p /mnt
            sudo mount "$ROOT_DEVICE" /mnt || fail "Failed to mount root partition"
          fi
        else
          # Regular filesystem mounting
          info "Mounting root partition..."
          sudo mkdir -p /mnt
          sudo mount "$ROOT_DEVICE" /mnt || fail "Failed to mount root partition"
        fi

        # Mount boot partition
        info "Mounting boot partition..."
        sudo mkdir -p /mnt/boot
        sudo mount "$BOOT_DEVICE" /mnt/boot || fail "Failed to mount boot partition"

        # Verify mounts
        info "Verifying mounts..."
        if ! mountpoint -q /mnt; then
          fail "Root filesystem not properly mounted"
        fi

        if ! mountpoint -q /mnt/boot; then
          fail "Boot filesystem not properly mounted"
        fi

        # Check if this looks like a NixOS system
        if [[ ! -d "/mnt/nix" ]] && [[ ! -d "/mnt/etc/nixos" ]]; then
          warn "This doesn't look like a NixOS system (no /nix or /etc/nixos found)"
          if ! gum confirm "Continue anyway?"; then
            info "Cleaning up mounts..."
            sudo umount /mnt/boot 2>/dev/null || true
            sudo umount /mnt 2>/dev/null || true
            exit 0
          fi
        fi

        success "Successfully mounted NixOS system!"
        info "Root: $(findmnt -n -o SOURCE /mnt) -> /mnt"
        info "Boot: $(findmnt -n -o SOURCE /mnt/boot) -> /mnt/boot"

        echo ""
        info "Entering NixOS system..."
        echo "💡 Inside the chroot you can:"
        echo "   • Run: nixos-rebuild switch"
        echo "   • Edit: /etc/nixos/configuration.nix"
        echo "   • Install bootloader: NIXOS_INSTALL_BOOTLOADER=1 /nix/var/nix/profiles/system/bin/switch-to-configuration boot"
        echo "   • Exit with: exit"
        echo ""

        # Enter the system
        exec sudo nixos-enter
      '';
    })
  ];

  services.getty.autologinUser = lib.mkForce "root";

  # Show welcome message on login
  environment.loginShellInit = ''
    welcome
  '';
}
