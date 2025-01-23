{
  description = "overcomplicated mess of a flake that works for some reason";

  inputs = {
    # Nixpkgs Unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Nixpkgs Stable
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-24.11";

    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository
    nur.url = "github:nix-community/NUR";

    # Nix helper
    nh.url = "github:viperML/nh";

    # Stylix, nix-colors alertnative
    stylix.url = "github:danth/stylix";

    # NixOS WSL, a way to use nix powers on windows
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Waybar, the wayland bar
    waybar.url = "github:/alexays/waybar";

    # Nixcord, a way to manage vencord plugins nix way
    nixcord.url = "github:kaylorben/nixcord";

    # A solution to your Wayland Wallpaper Woes
    swww.url = "github:LGFae/swww";

    # Zen Browser, a modern web browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # Ghostty, an overhyped modern terminal emulator
    ghostty.url = "github:ghostty-org/ghostty";

    # Hyprsunset, a hyprland way to manage screen temperature
    hyprsunset.url = "github:hyprwm/hyprsunset";

    astal-shell.url = "github:xhos/astal";

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:xhos/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Sops-nix, secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spicetify, a spotify theming tool
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland, the modern compositor for wayland
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # Hyprgrass, hyprland touch gestures plugin
    # hyprgrass = {
    #   url = "github:horriblename/hyprgrass";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # Hyprpicker, color picker for hyprland
    # hyprpicker.url = "github:hyprwm/hyprpicker";

    # Colorscheme generator
    # matugen.url = "github:InioX/matugen?ref=v2.2.0";

    # Cosmic, an unfinished, but promising de
    # nixpkgs.follows = "nixos-cosmic/nixpkgs";
    # nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nixos-wsl,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgsStable = import nixpkgs-stable {inherit system;};
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    # Or 'nh os switch'
    nixosConfigurations = {
      zireael = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          home-manager.nixosModule
          ./hosts/zireael/configuration.nix
        ];
      };
      vyverne = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          home-manager.nixosModule
          # inputs.nixos-cosmic.nixosModules.default
          ./hosts/vyverne/configuration.nix
        ];
      };
      aevon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/aevon/configuration.nix
          home-manager.nixosModule
          nixos-wsl.nixosModules.default
        ];
      };
    };
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    # Or 'nh home switch'
    homeConfigurations = {
      "xhos@zireael" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/xhos/zireael.nix
          inputs.sops-nix.homeManagerModules.sops
          inputs.nixcord.homeManagerModules.nixcord
          inputs.stylix.homeManagerModules.stylix
        ];
      };
      "xhos@vyverne" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.hyprpanel.overlay
          ];
        };
        # pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/xhos/vyverne.nix
          inputs.plasma-manager.homeManagerModules.plasma-manager
          inputs.sops-nix.homeManagerModules.sops
          inputs.nixcord.homeManagerModules.nixcord
          inputs.stylix.homeManagerModules.stylix
        ];
      };
      "xhos@aevon" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/xhos/aevon.nix
          inputs.stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}
