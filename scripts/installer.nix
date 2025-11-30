{pkgs}:
pkgs.writeShellApplication {
  name = "installer";

  runtimeInputs = with pkgs; [
    git
    jq
    gum
    disko
    rsync
  ];

  text = ''
    #!/usr/bin/env bash
    set -euo pipefail

    log() { printf "\033[1;34m[INFO]\033[0m %s\n" "$*"; }
    fail() { echo "$*" >&2; exit 1; }

    WORKDIR=/tmp/nixdots
    REPO_URL="https://github.com/xhos/nixdots.git"

    # clone or update repository
    if [ -d "$WORKDIR/.git" ]; then
      log "updating repo in $WORKDIR"
      git -C "$WORKDIR" fetch --prune --quiet
      git -C "$WORKDIR" reset --hard origin/HEAD --quiet
    else
      log "cloning $REPO_URL"
      git clone --depth=1 "$REPO_URL" "$WORKDIR"
    fi

    # select host
    HOST=$(nix flake show "$WORKDIR" --json \
      | jq -r '.nixosConfigurations | keys[]' \
      | gum choose --header "select machine")
    [ -n "$HOST" ] || fail "no host selected"

    HOST_DIR="$WORKDIR/hosts/$HOST"
    [ -d "$HOST_DIR" ] || fail "missing host directory: $HOST_DIR"

    CONFIG="$HOST_DIR/disko.nix"
    [ -f "$CONFIG" ] || fail "disko.nix missing"

    # select system disk
    DISK=$(lsblk -dpno NAME,SIZE \
      | gum choose --header "select system disk for \"$HOST\"" \
      | awk '{print $1}')
    [ -b "$DISK" ] || fail "invalid disk selected"

    # select data disk
    DATA_DISK=$(lsblk -dpno NAME,SIZE \
      | grep -v "$DISK" \
      | gum choose --header "select data disk for \"$HOST\"" \
      | awk '{print $1}')
    [ -b "$DATA_DISK" ] || fail "invalid data disk selected"

    gum confirm "warning: this will wipe $DISK and $DATA_DISK. continue?" || exit 1

    # run disko
    log "running disko on $DISK (system) and $DATA_DISK (data)"
    disko --mode zap_create_mount --argstr disk "$DISK" --argstr dataDisk "$DATA_DISK" "$CONFIG"

    # generate hardware config
    log "generating hardware-configuration.nix"
    nixos-generate-config --root /mnt --no-filesystems
    cp -f /mnt/etc/nixos/hardware-configuration.nix "$HOST_DIR/hardware-configuration.nix"

    if grep -q "impermanence.enable = true" "$HOST_DIR"/*.nix; then
      log "detected impermanence - syncing to /mnt/persist/etc/nixos"
      mkdir -p /mnt/persist/etc/nixos
      rsync -a --delete "$WORKDIR/" /mnt/persist/etc/nixos/
      FLAKE_PATH="/mnt/persist/etc/nixos"
    else
      log "syncing repo into /mnt/etc/nixos"
      rsync -a --delete "$WORKDIR/" /mnt/etc/nixos/
      FLAKE_PATH="/mnt/etc/nixos"
    fi

    # install
    log "installing nixos for $HOST from $FLAKE_PATH"
    nixos-install --root /mnt --flake "path:$FLAKE_PATH#$HOST"

    echo "done."
  '';
}
