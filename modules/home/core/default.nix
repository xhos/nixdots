{ inputs, config, pkgs, ... }: {
  wallpaper = ../../../home/shared/walls/${config.theme}.jpg;

  accent = config.lib.stylix.colors.base0D;

  background = config.lib.stylix.colors.base00;
  mantle     = config.lib.stylix.colors.base01;
  surface0   = config.lib.stylix.colors.base02;
  surface1   = config.lib.stylix.colors.base03;
  surface2   = config.lib.stylix.colors.base04;
  text       = config.lib.stylix.colors.base05;
  rosewater  = config.lib.stylix.colors.base06;
  lavender   = config.lib.stylix.colors.base07;
  red        = config.lib.stylix.colors.base08;
  peach      = config.lib.stylix.colors.base09;
  yellow     = config.lib.stylix.colors.base0A;
  green      = config.lib.stylix.colors.base0B;
  teal       = config.lib.stylix.colors.base0C;
  blue       = config.lib.stylix.colors.base0D;
  mauve      = config.lib.stylix.colors.base0E;
  flamingo   = config.lib.stylix.colors.base0F;

  home.sessionVariables = {
    ACCENT = config.accent;
    BACKGROUND = config.background;
    TEXT = config.text;
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
  };

  programs.ssh.addKeysToAgent = "yes";

  home.pointerCursor = {
    name = "phinger-cursors-dark";
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
