{pkgs, ...}: {
  imports = [../../modules/home];

  stylix.image =
    pkgs.fetchurl
    {
      url = "https://w.wallhaven.cc/full/6l/wallhaven-6lkyeq.png";
      sha256 = "sha256-YRcxOcDVHaEZNgQ+suCitgy2WSZIq0tH6T8sOB7J4EU=";
    };

  impermanence.enable = true;

  modules = {
    rofi.enable = true;
    firefox.enable = true;
    discord.enable = true;
    spicetify.enable = true;
    telegram.enable = true;
    fonts.enable = true;
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

  mainMonitor = "eDP-1";

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
