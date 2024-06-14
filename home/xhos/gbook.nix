{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  theme = "verdant";

  imports = [
    inputs.anyrun.homeManagerModules.default
    ../../modules/home
  ];

  modules = {
    anyrun.enable    = true;
    hyprland.enable  = true;
    k9s.enable       = false;
    lazygit.enable   = false;
    rofi.enable      = true;
    rbw.enable       = false; # CLI Bitwarden client
    spicetify.enable = true;
    sss.enable       = true;
    zellij.enable    = false;
    zsh.enable       = true;
  };

  default = {
    confDir = "/home/xhos/nixconf";

    de = "hyprland";
    bar = "ags";
    lock = "hyprlock";
    terminal = "kitty";
  };



  home = {
    packages = with pkgs; [
      (discord.override {withVencord = true;})
      scrcpy
      stremio
      yazi
      showmethekey
    ];
  };
}
