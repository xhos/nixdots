{
  description = "i don't know tf i'm doing";

  inputs = {
    # Nixpkgs Stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Nixpkgs uunstable
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-23.11";

    # awesome-git
    nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";

    # Home-manager
    hm.url = "github:nix-community/home-manager";

    # nix helper
    nh.url = "github:viperML/nh";

    # Nix colors, used for app theming
    nix-colors.url = "github:misterio77/nix-colors";

    # Stylix, nix-colors alertnative
    stylix.url = "github:danth/stylix";

    # Zellij plugin for statusbar
    zjstatus.url = "github:dj95/zjstatus";

    # Anyrun, an app launcher
    anyrun.url = "github:Kirottu/anyrun";

    # Ags, a customizable and extensible shell
    ags.url = "github:Aylur/ags";

    # Waybar, the wayland bar
    waybar.url = "github:/alexays/waybar";

    # Nix User Repository
    nur.url = "github:nix-community/NUR";

    # SuperScreenShot
    sss.url = "github:/SergioRibera/sss";

    # Hyprland, the modern compositor for wayland
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # Hyprspacem workspace overview plugin
    hyprspace.url = "github:KZDKM/Hyprspace";
    hyprspace.inputs.hyprland.follows = "hyprland";

    # Hyprpaper, wallpaper manager for hyprland
    hyprpaper.url = "github:hyprwm/hyprpaper";

    # hyprpicker, color picker for hyprland
    hyprpicker.url = "github:hyprwm/hyprpicker";

    # Split monitor workspaces, a plugin to get per monitor workspaces (similar to awesomewm)
    #split-monitor-workspaces.url = "github:Duckonaut/split-monitor-workspaces";
    #split-monitor-workspaces.inputs.hyprland.follows = "hyprland";

    # Spicetify, a spotify theming tool
    spicetify-nix.url = "github:the-argus/spicetify-nix";

    # My personal nixvim config
    nixvim.url = "github:elythh/nixvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    hm,
    stylix,
    nixpkgs-f2k,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgsStable = import nixpkgs-stable {inherit system;};
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      gbook = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          hm.nixosModule
          # nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen2
          {
            nixpkgs.overlays = [
              (final: prev: {
                awesome = nixpkgs-f2k.packages.${system}.awesome-git;
              })
            ];
          }
          ./hosts/gbook/configuration.nix
        ];
      };
    };
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "xhos@gbook" = inputs.hm.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs pkgsStable outputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home/xhos/gbook.nix
          stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}
