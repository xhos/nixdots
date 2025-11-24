{lib, ...}: {
  options = with lib; {
    impermanence.enable = mkEnableOption "nuke da home folder";

    modules = {
      firefox.enable = mkEnableOption "enable firefox";
      mpd.enable = mkEnableOption "enable mpd";
      rofi.enable = mkEnableOption "enable rofi";
      spicetify.enable = mkEnableOption "enable spicetify";
      discord.enable = mkEnableOption "enable discord";
      nvidia.enable = mkEnableOption "enable nvidia specific patches";
      secrets.enable = mkEnableOption "enable secrets management";
      telegram.enable = mkEnableOption "enable telegram";
      whisper.enable = mkEnableOption "enable whisper";
      obs.enable = mkEnableOption "enable obs";
      fonts.enable = mkEnableOption "enable fonts";
      syncthing.enable = mkEnableOption "enable syncthing";
    };

    headless = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "disable all gui related stuff";
    };

    mainMonitor = mkOption {
      type = types.str;
      description = "main monitor of the system, used for hyprlock";
      default = "";
    };

    hyprland = {
      hyprspace.enable = mkEnableOption "enable hyprland overview plugin";
    };

    de = mkOption {
      type = types.enum [
        "hyprland"
        "none"
      ];
      default = "none";
    };
    bar = mkOption {
      type = types.enum [
        "waybar"
        "none"
      ];
      default = "none";
    };
    browser = mkOption {
      type = types.enum [
        "firefox"
        "zen"
        "none"
      ];
      default = "none";
    };
    terminal = mkOption {
      type = types.enum [
        "wezterm"
        "foot"
        "ghostty"
        "none"
      ];
      default = "none";
    };
    prompt = mkOption {
      type = types.enum [
        "starship"
        "oh-my-posh"
        "none"
      ];
      default = "starship";
    };
    shell = mkOption {
      type = types.enum [
        "zsh"
        "fish"
        "nu"
      ];
      default = "zsh";
    };
  };
}
