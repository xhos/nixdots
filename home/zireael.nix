{pkgs, ...}: {
  imports = [../modules/home];

  stylix.image = pkgs.fetchurl {
    url = "https://pics.xhos.dev/u/Gyj0IG.jpeg";
    sha256 = "sha256-sy/KkYuQKf1JoYKldYDHed2V14qOqMfE3guSRVgc27E=";
  };

  impermanence.enable = true;

  modules = {
    rofi.enable = true;
    secrets.enable = true;
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

    # monitor = [
    #   "eDP-1,1920x1080@60.0,0x1080,1.0"
    #   "DP-6,1920x1080@60.0,0x0,1.0"
    #   "DP-7,2560x1440@59.95,1920x0,1.0"
    # ];
    #
    # monitor = [
    #   "eDP-1,1920x1080@60.0,0x840,1.0"
    #   "DP-2,1920x1080@144.0,1920x0,1.0"
    #   "DP-2,transform,3"
    # ];
  };
}
