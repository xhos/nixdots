{pkgs, ...}: {
  # https://tinted-theming.github.io/base16-gallery/
  theme = "tokyo-night-dark";
  wallsDir = "/home/xhos/Pictures/walls";

  imports = [../../modules/home];

  modules = {
    rofi.enable = true;
    firefox.enable = true;
    spicetify.enable = true;
  };

  default = {
    de = "hyprland";
    bar = "astal";
    lock = "hyprlock";
    shell = "zsh";
    prompt = "starship";
    browser = "zen";
    terminal = "foot";
  };

  home.packages = with pkgs; [
    iio-hyprland
    (vscode.override {commandLineArgs = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];})
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "iio-hyprland"
    ];

    monitor = [
      "eDP-1,1920x1080@60.0,1615x1685,1.0"
    ];
  };
}
