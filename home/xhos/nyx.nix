{pkgs, ...}: {
  theme = "tokyo-night-dark";

  imports = [
    ../../modules/home
  ];

  modules = {
    rofi.enable = true;
  };

  default = {
    de = "hyprland";
    bar = "none";
    lock = "none";
    shell = "zsh";
    prompt = "starship";
    browser = "zen";
    terminal = "foot";
  };

  wayland.windowManager.hyprland.settings.monitor = [
    "Virtual-1,1920x1080@60.0,0x0,2.0"
  ];

  home.packages = with pkgs; [
    (vscode.override {commandLineArgs = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];})
  ];
}
