{pkgs, ...}: {
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
  ];

  services.hypridle.enable = true;

  mainMonitor = "eDP-1";

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "iio-hyprland"

      # close camera shut on boot
      "echo 1 > /sys/class/firmware-attributes/samsung-galaxybook/attributes/block_recording/current_value"
    ];
  };
}
