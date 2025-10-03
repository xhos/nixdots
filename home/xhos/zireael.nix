{pkgs, ...}: {
  imports = [../../modules/home];

  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/je/wallhaven-je335m.png";
    sha256 = "sha256-X4LnmsHMstA0sUwmWR2uxwULT1qBstwsXZ0P6ghxgxg=";
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

  de = "hyprland";
  bar = "waybar";
  shell = "zsh";
  prompt = "starship";
  browser = "zen";
  terminal = "foot";

  home.packages = with pkgs; [
    iio-hyprland
    (vscode.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    })
  ];

  services.hypridle.enable = true;

  mainMonitor = "eDP-1";

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "iio-hyprland"

      # close camera shut on boot
      "echo 1 > /sys/class/firmware-attributes/samsung-galaxybook/attributes/block_recording/current_value"
    ];

    monitor = [
      "eDP-1,1920x1080@60.0,0x840,1.0"
      "DP-2,1920x1080@144.0,1920x0,1.0"
      "DP-2,transform,3"
    ];
  };
}
