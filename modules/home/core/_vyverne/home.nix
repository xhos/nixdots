{
  pkgs,
  config,
  lib,
  ...
}: {
  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/rd/wallhaven-rdwjj7.jpg";
    sha256 = "sha256-Gv/2Ap8YS6F1S1RXlwQr71MMi+iRi9fgvZVVyZeCKvk=";
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
    syncthing.enable = true;
  };

  de = "hyprland";
  bar = "waybar";
  shell = "zsh";
  prompt = "starship";
  browser = "zen";
  terminal = "foot";

  mainMonitor = "Microstep MAG 274UPF E2 0x00000001";

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace special silent] spotify"
      "[workspace 10 silent] materialgram"
      "[workspace 10 silent] equibop"
    ];

    windowrulev2 = [
      "workspace special silent, initialClass: spotify"
      "workspace 10 silent, initialClass: equibop"
      "workspace 10 silent, initialTitle: materialgram"
    ];
  };

  services.kdeconnect.enable = true;

  sops.secrets = lib.mkIf config.modules.syncthing.enable {
    "syncthing/vyverne/cert".mode = "0400";
    "syncthing/vyverne/key".mode = "0400";
  };

  services.syncthing.settings = lib.mkIf config.modules.syncthing.enable {
    key = config.sops.secrets."syncthing/vyverne/key".path;
    cert = config.sops.secrets."syncthing/vyverne/cert".path;
  };
}
