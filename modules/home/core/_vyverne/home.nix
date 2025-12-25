{pkgs, ...}: {
  stylix.image = pkgs.fetchurl {
    url = "https://images.unsplash.com/photo-1502252430442-aac78f397426";
    sha256 = "sha256-PQM8Jy1CA/j7srpqi3gnk4EAZKFWTKBiB/39utsIPmQ=";
  };

  stylix.base16Scheme = ./min-dark.yaml;

  impermanence.enable = true;

  modules = {
    rofi.enable = true;
    spicetify.enable = true;
    firefox.enable = true;
    discord.enable = true;
    secrets.enable = true;
    telegram.enable = true;
    obs.enable = true;
    whisper.enable = true;
    fonts.enable = true;
  };

  de = "hyprland";
  bar = "waybar";
  shell = "zsh";
  prompt = "starship";
  browser = "zen";
  terminal = "ghostty";

  mainMonitor = "Microstep MAG 274UPF E2 0x00000001";

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace special silent] spotify"
      "[workspace 10 silent] materialgram"
      "[workspace 10 silent] discord"
    ];

    windowrulev2 = [
      "workspace special silent, initialClass: spotify"
      "workspace 10 silent, initialTitle: materialgram"
      "workspace 10 silent, initialClass: discord"
    ];
  };

  services.kdeconnect.enable = true;
}
