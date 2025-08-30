{pkgs}:
pkgs.writeShellApplication {
  name = "enter-helper";
    runtimeInputs = with pkgs; [
    # Core utilities
    gum 
    util-linux 
    zfs
    
    # Additional useful tools you might want
    coreutils    # Basic utilities (cp, mv, ls, etc.)
    findutils    # find, xargs
    gnugrep      # grep
    gnused       # sed
    gawk         # awk
    bash         # Ensure bash is available
    ncurses      # For terminal capabilities
    
    # System tools
    psmisc       # pstree, killall
    procps       # ps, top, kill
    systemd      # systemctl, journalctl
    
    # Network tools (if needed)
    # iproute2   # ip command
    # nettools   # ifconfig, netstat
    
    # Text editors (uncomment if desired)
    # nano
    # vim
  ];
  text = ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Colors and formatting
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    PURPLE='\033[0;35m'
    NC='\033[0m'

    fail() {
      echo -e "$RED❌ Error:$NC $*" >&2
      exit 1
    }

    info() { echo -e "$BLUE ℹ️  $NC $*"; }
    success() { echo -e "$GREEN✅$NC $*"; }
    warn() { echo -e "$YELLOW⚠️ $NC $*"; }

    # Check if we're running as root
    if [[ $EUID -eq 0 ]]; then
      warn "Running as root. Be careful!"
    fi

    echo -e "$PURPLE🔧 NixOS Enter Helper$NC"
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

    # Get partition information
    info "Scanning for partitions..."

    partition_list=$(lsblk -lno NAME,SIZE,FSTYPE,MOUNTPOINT,LABEL | \
      grep -E "^[a-z]+[0-9]+" | \
      while read -r name size fstype mountpoint label _; do
        display="$name"
        [[ -n "$size" ]] && display="$display ($size)"
        [[ -n "$fstype" ]] && display="$display [$fstype]"
        [[ -n "$label" ]] && display="$display {$label}"
        [[ -n "$mountpoint" ]] && display="$display -> $mountpoint"
        echo "/dev/$name|$display"
      done)

    [[ -n "$partition_list" ]] || fail "No partitions found."

    echo ""
    info "Found partitions:"
    echo "$partition_list" | cut -d'|' -f2

    # Select root partition
    ROOT_DEVICE=$(echo "$partition_list" | gum choose --header "🗂️  Select ROOT partition:" | cut -d'|' -f1)
    [[ -n "$ROOT_DEVICE" ]] || fail "No root partition selected"

    ROOT_FSTYPE=$(lsblk -no FSTYPE "$ROOT_DEVICE" 2>/dev/null || echo "unknown")
    success "Selected root: $ROOT_DEVICE ($ROOT_FSTYPE)"

    # Select boot partition
    BOOT_DEVICE=$(echo "$partition_list" | gum choose --header "🥾 Select BOOT/EFI partition:" | cut -d'|' -f1)
    [[ -n "$BOOT_DEVICE" ]] || fail "No boot partition selected"

    BOOT_FSTYPE=$(lsblk -no FSTYPE "$BOOT_DEVICE" 2>/dev/null || echo "unknown")
    success "Selected boot: $BOOT_DEVICE ($BOOT_FSTYPE)"

    echo ""
    info "About to mount:"
    echo "  Root: $ROOT_DEVICE ($ROOT_FSTYPE) -> /mnt"
    echo "  Boot: $BOOT_DEVICE ($BOOT_FSTYPE) -> /mnt/boot"

    gum confirm "Proceed with mounting and entering NixOS?" || exit 0

    # Unmount existing
    info "Unmounting any existing /mnt mounts..."
    for mount in $(mount | grep "/mnt" | awk '{print $3}' | sort -r); do
      warn "Unmounting $mount"
      sudo umount -l "$mount" 2>/dev/null || true
    done

    # Handle ZFS
    if [[ "$ROOT_FSTYPE" == "zfs_member" ]]; then
      info "Detected ZFS filesystem. Importing ZFS pools..."

      available_pools=$(sudo zpool import 2>/dev/null | grep "pool:" | awk '{print $2}' || echo "")
      if [[ -n "$available_pools" ]]; then
        POOL=$(echo "$available_pools" | gum choose --header "📦 Select ZFS pool:")
        [[ -n "$POOL" ]] || fail "No ZFS pool selected"

        info "Importing ZFS pool: $POOL"
        sudo zpool import -f "$POOL" || fail "Failed to import ZFS pool"

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
        info "Mounting root partition..."
        sudo mkdir -p /mnt
        sudo mount "$ROOT_DEVICE" /mnt || fail "Failed to mount root partition"
      fi
    else
      info "Mounting root partition..."
      sudo mkdir -p /mnt
      sudo mount "$ROOT_DEVICE" /mnt || fail "Failed to mount root partition"
    fi

    # Mount boot
    info "Mounting boot partition..."
    sudo mkdir -p /mnt/boot
    sudo mount "$BOOT_DEVICE" /mnt/boot || fail "Failed to mount boot partition"

    # Verify mounts
    mountpoint -q /mnt || fail "Root filesystem not properly mounted"
    mountpoint -q /mnt/boot || fail "Boot filesystem not properly mounted"

    # Check if NixOS
    if [[ ! -d "/mnt/nix" ]] && [[ ! -d "/mnt/etc/nixos" ]]; then
      warn "This doesn't look like a NixOS system"
      gum confirm "Continue anyway?" || {
        sudo umount /mnt/boot /mnt 2>/dev/null || true
        exit 0
      }
    fi

    success "Successfully mounted NixOS system!"
    info "Root: $(findmnt -n -o SOURCE /mnt) -> /mnt"
    info "Boot: $(findmnt -n -o SOURCE /mnt/boot) -> /mnt/boot"

    echo ""
    info "Entering NixOS system..."
    echo "💡 Inside the chroot you can:"
    echo "   • Run: nixos-rebuild switch"
    echo "   • Edit: /etc/nixos/configuration.nix"
    echo "   • Exit with: exit"

    exec sudo nixos-enter
  '';
}
