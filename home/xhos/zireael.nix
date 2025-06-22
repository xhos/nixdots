{pkgs, ...}: {
  # https://tinted-theming.github.io/base16-gallery/
  theme = "tokyo-night-dark";

  imports = [../../modules/home];

  optPkgs.enable = true;

  stylix.image =
    pkgs.fetchurl
    {
      url = "https://w.wallhaven.cc/full/o3/wallhaven-o3km89.png";
      sha256 = "sha256-11Dk/EDBQPH9V/+RnMAkMBsW7wLhFiv8qU4ve72jT8A=";
    };

  modules = {
    rofi.enable = true;
    firefox.enable = true;
    spicetify.enable = true;
  };

  default = {
    de = "hyprland";
    bar = "waybar";
    shell = "zsh";
    prompt = "starship";
    browser = "zen";
    terminal = "foot";
  };

  home.packages = with pkgs; [
    iio-hyprland
    (vscode.override {commandLineArgs = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];})
  ];

  services.hypridle.enable = true;

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
