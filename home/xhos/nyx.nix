{
  lib,
  pkgs,
  ...
}: {
  theme = "tokyo-night-dark";

  imports = [
    ../../modules/home
  ];

  modules = {
    rofi.enable = true;
  };

  default = {
    de = "hyprland";
    bar = "quickshell";
    lock = "hyprlock";
    shell = "zsh";
    prompt = "starship";
    browser = "zen";
    terminal = "foot";
  };

  wayland.windowManager.hyprland.settings.monitor = [
    "Virtual-1,1920x1080@60.0,0x0,2.0"
  ];

  home = {
    username = "xhos";
    homeDirectory = "/home/xhos";
    stateVersion = "25.05";
    packages = with pkgs; [
      (vscode.override {commandLineArgs = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];})
    ];
  };
}
