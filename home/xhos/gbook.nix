{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  theme = "verdant";

  imports = [
    ../../modules/home
  ];

  modules = {
    hyprland.enable  = true;
    rofi.enable      = true;
    spicetify.enable = true;
    zsh.enable       = true;
  };

  default = {
    de = "hyprland";
    bar = "ags";
    lock = "hyprlock";
    terminal = "foot";
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
