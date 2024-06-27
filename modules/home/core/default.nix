{ inputs, config, pkgs, ... }: {
  wallpaper = ../../../home/shared/walls/${config.theme}.jpg;
  background = config.lib.stylix.colors.base00;
  text = config.lib.stylix.colors.base05;
  accent = config.lib.stylix.colors.base0D;

  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };

  imports = [
    ./gtk.nix
    ./nixpkgs.nix
    ./options.nix
    ./overlays.nix
    ./programs.nix
    ./style/stylix.nix
    ./home.nix
  ];

  programs.home-manager.enable = true;
}
