{pkgs, ...}: {
  # https://tinted-theming.github.io/base16-gallery/
  theme = "tokyo-night-dark";

  imports = [../../modules/home];

  optPkgs.enable = true;

  modules = {
    rofi.enable = true;
    firefox.enable = true;
    spicetify.enable = true;
  };

  default = {
    de = "hyprland";
    bar = "aard";
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
      "eDP-1,1920x1080@60.0,0x840,1.0"
      "DP-2,1920x1080@144.0,1920x0,1.0"
      "DP-2,transform,3"
    ];
  };
}
