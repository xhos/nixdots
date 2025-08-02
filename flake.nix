{
  description = "overcomplicated mess of a flake that works for some reason";

  inputs = {
    # nixpkgs unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # nixpkgs stable
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-24.11";

    # ocd godsend
    impermanence.url = "github:nix-community/impermanence";

    # declarative disk management
    disko.url = "github:nix-community/disko";

    # use nix powers on windows
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # manage vencord plugins nix way
    nixcord.url = "github:kaylorben/nixcord";

    # cool browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # aard, my own astal bar
    aard.url = "github:xhos/aard";

    # home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # style manager
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spotify theming tool
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # private secrets repository
    nix-secrets = {
      url = "git+ssh://git@github.com/xhos/nix-secrets?ref=main&allRefs=1";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    nixosConfigurations = {
      zireael = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          {
            home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };
            home-manager.users."xhos" = ./home/xhos/zireael.nix;
          }
          ./hosts/zireael/configuration.nix
        ];
      };

      vyverne = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };
            home-manager.users."xhos" = ./home/xhos/vyverne.nix;
          }
          inputs.stylix.nixosModules.stylix
          inputs.disko.nixosModules.disko
          inputs.impermanence.nixosModules.impermanence
          inputs.sops-nix.nixosModules.sops
          ./hosts/vyverne/configuration.nix
        ];
      };

      aevon = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };
            home-manager.users."xhos" = ./home/xhos/aevon.nix;
          }
          inputs.stylix.nixosModules.stylix
          ./hosts/aevon/configuration.nix
          nixos-wsl.nixosModules.default
        ];
      };

      # nix run nixpkgs#nixos-generators -- --format iso --flake .#nyx -o iso
      nyx = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/nyx/configuration.nix ];
      };
    };

    ########################################
    # nix run entrypoint(s)
    ########################################
    apps.${system}.aevon-install =
      let
        script = pkgs.writeShellApplication {
          name = "aevon-install";
          runtimeInputs = [ pkgs.git pkgs.coreutils pkgs.util-linux ];
          text = ''
            #!/usr/bin/env bash
            set -euo pipefail

            REPO_URL="''${REPO_URL:-https://github.com/xhos/nixdots.git}"
            BRANCH="''${BRANCH:-main}"
            DEST_DIR="/etc/nixos"
            FLAKE_HOST="aevon"

            is_wsl() { grep -qi microsoft /proc/sys/kernel/osrelease; }
            need_root() { [ "$(id -u)" -eq 0 ] || exec sudo -E "$0" "$@"; }

            need_root "$@"
            if ! is_wsl; then
              echo "✗ Not running inside WSL. Aborting."
              exit 1
            fi

            echo "→ Cloning $REPO_URL ($BRANCH) into ''${DEST_DIR} …"
            rm -rf "''${DEST_DIR}"
            git clone --branch "$BRANCH" --depth 1 "$REPO_URL" "''${DEST_DIR}"

            echo "→ chmod -R 777 ''${DEST_DIR} (per your requirement)"
            chmod -R 777 "''${DEST_DIR}"

            # sanity: ensure the host exists
            if [ ! -f "''${DEST_DIR}/hosts/''${FLAKE_HOST}/configuration.nix" ]; then
              echo "✗ ''${DEST_DIR}/hosts/''${FLAKE_HOST}/configuration.nix not found."
              echo "  Make sure your repo defines nixosConfigurations.''${FLAKE_HOST}."
              exit 1
            fi

            echo "→ Building boot generation for ''${FLAKE_HOST} (applies wsl.defaultUser on relog)…"
            nixos-rebuild boot --flake "''${DEST_DIR}#''${FLAKE_HOST}"

            cat <<'EOM'

✓ Boot generation built.

Now apply it (one-time WSL relog sequence):

  PowerShell/CMD:
    wsl -t Aevon            # stop the distro
    wsl -d Aevon --user root -- echo applied
    wsl -t Aevon
    wsl -d Aevon            # start normally (default user takes effect)

Optionally run:
  sudo nixos-rebuild switch --flake /etc/nixos#aevon
EOM
          '';
        };
      in
      {
        type = "app";
        program = "${script}/bin/aevon-install";
      };

    ########################################
    # Standalone home-manager configurations
    ########################################
    homeConfigurations = {
      "xhos@zireael" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };
        modules = [
          ./home/xhos/zireael.nix
          inputs.sops-nix.homeManagerModules.sops
          inputs.stylix.homeModules.stylix
        ];
      };

      "xhos@vyverne" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; overlays = [ inputs.aard.overlay ]; };
        extraSpecialArgs = { inherit inputs system; };
        modules = [
          ./home/xhos/vyverne.nix
          inputs.sops-nix.homeManagerModules.sops
          inputs.stylix.homeModules.stylix
        ];
      };

      "xhos@aevon" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home/xhos/aevon.nix
          inputs.stylix.homeModules.stylix
        ];
      };
    };
  };
}
