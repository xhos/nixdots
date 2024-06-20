{
  inputs,
  config,
  ...
}: {
  wallpaper = ../../../home/shared/walls/${config.theme}.jpg;
  background = config.lib.stylix.colors.base00;
  text = config.lib.stylix.colors.base05;
  accent = config.lib.stylix.colors.base0D;
  # home.sessionVariables.EDITOR = "nvim";
  imports = [
    ./gtk.nix
    ./nixpkgs.nix
    ./options.nix
    ./overlays.nix
    ./programs.nix
    ./style/stylix.nix
    ./home.nix
    inputs.nix-colors.homeManagerModules.default
  ];

  programs.home-manager.enable = true;
}
