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
    (writeShellApplication {
      name = "i";
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        fail() { echo "$*" >&2; exit 1; }

        WORKDIR=/tmp/nixdots

        # Clone or update repository
        if [ -d "$WORKDIR/.git" ]; then
          git -C "$WORKDIR" pull --ff-only
        else
          git clone https://github.com/xhos/nixdots.git "$WORKDIR"
        fi

        # Select host
        HOST=$(nix flake show "$WORKDIR" --json \
                | jq -r '.nixosConfigurations | keys[]' \
                | gum choose --header "Select machine")
        [ -n "$HOST" ] || fail "No host selected"

        # Select disk
        DISK=$(lsblk -dpno NAME,SIZE \
                | gum choose --header "Select target disk for \"$HOST\"" \
                | awk '{print $1}')
        [ -b "$DISK" ] || fail "Invalid disk selected"

        gum confirm "⚠️  Wipe $DISK? Continue?" || exit 1

        # Run disko
        CONFIG="$WORKDIR/hosts/$HOST/disko.nix"
        ls -l "$CONFIG" || fail "disko.nix missing"

        disko --mode zap_create_mount \
          --argstr disk "$DISK" \
          "$CONFIG" || fail "disko failed"

        # Generate hardware config
        nixos-generate-config --root /mnt --no-filesystems

        # Move hardware config
        mv /mnt/etc/nixos/hardware-configuration.nix \
           "$WORKDIR/hosts/$HOST/"

        # Sync repository
        rsync -a --delete "$WORKDIR/" /mnt/etc/nixos/

        # Install NixOS
        nixos-install --root /mnt --flake /mnt/etc/nixos#"$HOST" --no-root-passwd

        echo "✅ Done. Reboot."
      '';
    })
  ];

  services.getty.autologinUser = lib.mkForce "root";
}
