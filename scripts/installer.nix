{pkgs}:
pkgs.writeShellApplication {
  name = "installer";
  runtimeInputs = with pkgs; [git jq gum disko rsync];
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

    CONFIG="$HOST_DIR/disko.nix"
    [ -f "$CONFIG" ] || fail "disko.nix missing"

    # Select system disk
    DISK=$(lsblk -dpno NAME,SIZE \
      | gum choose --header "Select SYSTEM disk for \"$HOST\"" \
      | awk '{print $1}')
    [ -b "$DISK" ] || fail "Invalid disk selected"

    # Select data disk
    DATA_DISK=$(lsblk -dpno NAME,SIZE \
      | grep -v "$DISK" \
      | gum choose --header "Select DATA disk for \"$HOST\"" \
      | awk '{print $1}')
    [ -b "$DATA_DISK" ] || fail "Invalid data disk selected"

    gum confirm "⚠️ This will WIPE $DISK and $DATA_DISK. Continue?" || exit 1

    # Run disko
    log "Running disko on $DISK (system) and $DATA_DISK (data)"
    disko --mode zap_create_mount --argstr disk "$DISK" --argstr dataDisk "$DATA_DISK" "$CONFIG"

    # Generate hardware config
    log "Generating hardware-configuration.nix"
    nixos-generate-config --root /mnt --no-filesystems
    cp -f /mnt/etc/nixos/hardware-configuration.nix "$HOST_DIR/hardware-configuration.nix"

    if grep -q "impermanence.enable = true" "$HOST_DIR"/*.nix; then
      log "Detected impermanence - syncing to /mnt/persist/etc/nixos"
      mkdir -p /mnt/persist/etc/nixos
      rsync -a --delete "$WORKDIR/" /mnt/persist/etc/nixos/
      FLAKE_PATH="/mnt/persist/etc/nixos"
    else
      log "Syncing repo into /mnt/etc/nixos"
      rsync -a --delete "$WORKDIR/" /mnt/etc/nixos/
      FLAKE_PATH="/mnt/etc/nixos"
    fi

    # Install
    log "Installing NixOS for $HOST from $FLAKE_PATH"
    nixos-install --root /mnt --flake "path:$FLAKE_PATH#$HOST" --no-root-passwd

    echo "✅ Done. Reboot or run 'nix run github:xhos/nixdots#nixos-enter-helper' to enter."
  '';
}
