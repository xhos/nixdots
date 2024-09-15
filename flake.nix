{
  description = "my os flake";

  inputs = {
    # Nixpkgs Stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Nixpkgs unstable
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-23.11";

    # Home-manager
    hm.url = "github:nix-community/home-manager";

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

    # Hyprland, the modern compositor for wayland
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # Nixcord, a way to manage vencord plugins nix way
    nixcord.url = "github:kaylorben/nixcord";

    # Hyprpicker, color picker for hyprland
    hyprpicker.url = "github:hyprwm/hyprpicker";

    # Colorscheme generator
    matugen.url = "github:InioX/matugen?ref=v2.2.0";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprspace, hyprland workspace overview plugin
    # hyprspace = {
    #   url = "github:KZDKM/Hyprspace";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # Hyprgrass, hyprland touch gestures plugin
    hyprgrass = {
        url = "github:horriblename/hyprgrass";
        inputs.hyprland.follows = "hyprland";
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

    # Rust prject helper
    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Wezterm unstable
    wezterm = {
      url = "git+https://github.com/wez/wezterm.git?submodules=1";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, hm, nixos-wsl, ... }@inputs:
  let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgsStable = import nixpkgs-stable { inherit system; };
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    # Or 'nh os switch'
    nixosConfigurations = {
      zireael = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          hm.nixosModule
          ./hosts/zireael/configuration.nix
        ];
      };
      aevon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/aevon/configuration.nix
          hm.nixosModule
          nixos-wsl.nixosModules.default
        ];
      };
    };
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    # Or 'nh home switch'
    homeConfigurations = {
      "xhos@zireael" = inputs.hm.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home/xhos/zireael.nix
          inputs.sops-nix.homeManagerModules.sops
          inputs.nixcord.homeManagerModules.nixcord
          inputs.stylix.homeManagerModules.stylix
        ];
      };
      "xhos@aevon" = inputs.hm.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home/xhos/aevon.nix
          inputs.sops-nix.homeManagerModules.sops
          inputs.nixcord.homeManagerModules.nixcord
          inputs.stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}
