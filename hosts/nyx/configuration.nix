{
  modulesPath,
  pkgs,
  lib,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  networking.wireless.enable = true;
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
      name = "install";
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        fail() { echo "--> $*" >&2; exit 1; }

        # 1) Where to put the repo
        WORKDIR=/tmp/nixdots

        # 2) Clone or pull
        if [ -d "$WORKDIR/.git" ]; then
          git -C "$WORKDIR" pull --ff-only
        else
          git clone https://github.com/xhos/nixdots.git "$WORKDIR"
        fi

        # 3) List hosts in the flake
        HOST=$(nix flake show "$WORKDIR" --json |
               jq -r '.nixosConfigurations | keys[]' |
               gum choose --header "Select machine")
        [ -n "$HOST" ] || fail "No host selected"

        # 4) Pick a disk
        DISK=$(lsblk -dpno NAME,SIZE |
               gum choose --header "Select target disk for \"$HOST\"" |
               awk '{print $1}')
        [ -b "$DISK" ] || fail "Invalid disk selected"

        gum confirm "⚠️  All data on \"$DISK\" will be destroyed. Continue?" || exit 1

        # 5) Partition
        nix run github:nix-community/disko -- \
              --arg disk "\"$DISK\"" --mode zap_create_mount \
              "$WORKDIR/hosts/$HOST/disko.nix"

        # 6) Generate hardware-configuration.nix
        nixos-generate-config --root /mnt --no-filesystems
        mv /mnt/etc/nixos/hardware-configuration.nix \
           "$WORKDIR/hosts/$HOST/"

        # 7) Copy repo onto target root
        rsync -a --delete "$WORKDIR/" /mnt/etc/nixos/

        # 8) Install
        nixos-install --root /mnt --flake /mnt/etc/nixos#"$HOST" --no-root-passwd

        echo "✅ Done. Reboot."
      '';
    })
  ];

  services.getty.autologinUser = lib.mkForce "root";
}
