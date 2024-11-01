{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  # https://tinted-theming.github.io/base16-gallery/
  theme = "tokyo-night-dark";
  wallsDir = "/home/xhos/Pictures/walls";

  imports = [../../modules/home];

  modules = {
    rofi.enable = true;
    spicetify.enable = true;
    firefox.enable = true;
    discord.enable = true;
  };

  default = {
    de = "hyprland";
    bar = "waybar";
    lock = "hyprlock";
    shell = "fish";
    prompt = "starship";
    terminal = "foot";
  };

  home.packages = with pkgs; [
    iio-hyprland
    (vscode.override {commandLineArgs = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];})
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "iio-hyprland"
  ];
}
