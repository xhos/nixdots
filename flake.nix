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

    # priavte secrets repository
    nix-secrets = {
      url = "git+ssh://git@github.com/xhos/nix-secrets?shallow=1&ref=main";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-wsl,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    # Or 'nh os switch'
    nixosConfigurations = {
      zireael = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          {
            home-manager.extraSpecialArgs = {
              inherit inputs;
              system = "x86_64-linux";
            };
            home-manager.users."xhos" = ./home/xhos/zireael.nix;
          }
          ./hosts/zireael/configuration.nix
        ];
      };
      vyverne = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit inputs;
              system = "x86_64-linux";
            };
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
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit inputs;
              system = "x86_64-linux";
            };
            home-manager.users."xhos" = ./home/xhos/aevon.nix;
          }
          inputs.stylix.nixosModules.stylix
          ./hosts/aevon/configuration.nix
          nixos-wsl.nixosModules.default
        ];
      };
      # nix run nixpkgs#nixos-generators -- --format iso --flake .#nyx -o iso
      nyx = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nyx/configuration.nix
        ];
      };
    };
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    # Or 'nh home switch'
    homeConfigurations = {
      "xhos@zireael" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          system = "x86_64-linux";
        };
        modules = [
          ./home/xhos/zireael.nix
          inputs.sops-nix.homeManagerModules.sops
          inputs.stylix.homeModules.stylix
        ];
      };
      "xhos@vyverne" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.aard.overlay
          ];
        };
        # pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs system;};
        modules = [
          ./home/xhos/vyverne.nix
          inputs.sops-nix.homeManagerModules.sops
          inputs.stylix.homeModules.stylix
        ];
      };
      "xhos@aevon" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/xhos/aevon.nix
          inputs.stylix.homeModules.stylix
        ];
      };
    };
  };
}
