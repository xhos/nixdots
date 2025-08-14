{
  description = "overcomplicated mess of a system flake that works for some reason";

  inputs = {
    aard.url = "github:xhos/aard"; # aard, my own astal bar
    disko.url = "github:nix-community/disko"; # declarative disk management
    hedge.url = "github:KZDKM/Hedge"; # hot edge hyprland plugin
    impermanence.url = "github:nix-community/impermanence"; # ocd godsend
    logi-hypr.url = "github:xhos/logi-hypr"; # gestures for my mx master 3s
    nixcord.url = "github:kaylorben/nixcord"; # manage vencord plugins nix way
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main"; # use nix powers on windows
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-24.11"; # nixpkgs stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # nixpkgs unstable
    zen-browser.url = "github:0xc000022070/zen-browser-flake"; # cool browser

    home-manager = {
      url = "github:nix-community/home-manager"; # home-manager
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix"; # style manager
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix"; # secrets management
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix"; # spotify theming tool
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "git+ssh://git@github.com/xhos/nix-secrets?ref=main&allRefs=1"; # private secrets repository
      flake = false;
    };

    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake"; # i need my mcp's
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    npins = import ./npins;
    mkNixosSystem = {
      hostname,
      modules ? [],
      homeUser ? "xhos",
      extraSpecialArgs ? {},
    }:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs npins;} // extraSpecialArgs;
        modules =
          [
            ./hosts/${hostname}/configuration.nix
          ]
          ++ (
            if homeUser != null
            then [
              home-manager.nixosModules.home-manager
              inputs.stylix.nixosModules.stylix
              inputs.impermanence.nixosModules.impermanence
              {
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  system = "x86_64-linux";
                };
                home-manager.users."${homeUser}" = ./home/${homeUser}/${hostname}.nix;
              }
            ]
            else [
              inputs.stylix.nixosModules.stylix
            ]
          )
          ++ modules;
      };
  in {
    nixosConfigurations = {
      zireael = mkNixosSystem {
        hostname = "zireael";
        modules = [
          inputs.disko.nixosModules.disko
          inputs.sops-nix.nixosModules.sops
        ];
      };

      vyverne = mkNixosSystem {
        hostname = "vyverne";
        modules = [
          inputs.disko.nixosModules.disko
          inputs.sops-nix.nixosModules.sops
        ];
      };

      aevon = mkNixosSystem {
        hostname = "aevon";
        modules = [inputs.nixos-wsl.nixosModules.default];
      };

      nyx = mkNixosSystem {
        hostname = "nyx";
        homeUser = null;
      };
    };
  };
}
