{
  description = "overcomplicated mess of a system flake that works for some reason";

  inputs = {
    nxv.url = "github:xhos/nxv"; # my nvim config
    disko.url = "github:nix-community/disko"; # declarative disk management
    impermanence.url = "github:nix-community/impermanence"; # ocd godsend
    logi-hypr.url = "github:xhos/logi-hypr"; # gestures for my mx master 3s
    nixcord.url = "github:kaylorben/nixcord"; # manage vencord plugins nix way
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main"; # use nix powers on windows
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-24.11"; # nixpkgs stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # nixpkgs unstable
    zen-browser.url = "github:0xc000022070/zen-browser-flake"; # cool browser
    vpn-confinement.url = "github:Maroka-chan/VPN-Confinement";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    wled-album-sync.url = "github:xhos/wled-album-sync";
    proxmox-nixos.url = "github:SaumonNet/proxmox-nixos";
    yawn.url = "github:xhos/yawn";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tsutsumi = {
      url = "github:Fuwn/tsutsumi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # private secrets repository
    nix-secrets = {
      url = "git+ssh://git@github.com/xhos/nix-secrets?ref=main&allRefs=1";
      flake = false;
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland";
    };

    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };

    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
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
        specialArgs =
          {
            inherit inputs npins;
          }
          // extraSpecialArgs;
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
                home-manager.extraSpecialArgs = {inherit inputs;};
                home-manager.backupFileExtension = ".b";
                home-manager.users."${homeUser}" = ./home/${homeUser}/${hostname}.nix;
              }
            ]
            else [
              inputs.stylix.nixosModules.stylix
            ]
          )
          ++ modules;
      };
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forEachSystem = nixpkgs.lib.genAttrs systems;
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
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

      enrai = mkNixosSystem {
        hostname = "enrai";
        modules = [
          inputs.vpn-confinement.nixosModules.default
          inputs.disko.nixosModules.disko
          inputs.vscode-server.nixosModules.default
          inputs.wled-album-sync.nixosModules.default
          inputs.proxmox-nixos.nixosModules.proxmox-ve
        ];
      };
    };

    packages = forEachSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        enterHelper = import ./scripts/enter-helper.nix {inherit pkgs;};
        installer = import ./scripts/installer.nix {inherit pkgs;};
        iso-to-usb = import ./scripts/iso-to-usb.nix {inherit pkgs;};
      in {
        default = installer;
        enter-helper = enterHelper;
        installer = installer;
        iso-to-usb = iso-to-usb;
      }
    );
  };
}
