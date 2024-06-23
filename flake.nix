{
  description = "i don't know tf i'm doing";

  inputs = {
    # Nixpkgs Stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Nixpkgs unstable
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-23.11";

    # Home-manager
    hm.url = "github:nix-community/home-manager";

    # nix helper
    nh.url = "github:viperML/nh";

    # Stylix, nix-colors alertnative
    stylix.url = "github:danth/stylix";

    # Ags, a customizable and extensible shell
    ags.url = "github:Aylur/ags";

    # Waybar, the wayland bar
    waybar.url = "github:/alexays/waybar";

    # Nix User Repository
    nur.url = "github:nix-community/NUR";

    # Hyprland, the modern compositor for wayland
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # Hyprspacem workspace overview plugin
    hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    # Hyprpicker, color picker for hyprland
    hyprpicker.url = "github:hyprwm/hyprpicker";

    # Spicetify, a spotify theming tool
    spicetify-nix.url = "github:the-argus/spicetify-nix";

    # Colorscheme generator
    matugen.url = "github:InioX/matugen?ref=v2.2.0";

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

  outputs = { self, nixpkgs, nixpkgs-stable, hm, stylix, ... }@inputs:
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
          inputs.stylix.nixosModules.stylix
          ./hosts/zireael/configuration.nix
        ];
      };
    };
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    # Or 'nh home switch'
    homeConfigurations = {
      "xhos@zireael" = inputs.hm.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home/xhos/zireael.nix
          # stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}
