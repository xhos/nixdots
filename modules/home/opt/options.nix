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
    };

    mainMonitor = mkOption {
      type = types.str;
      description = "main monitor of the system, used for hyprlock";
    };

    hyprland = {
      hyprspace.enable = mkEnableOption "enable hyprland overview plugin";
    };

    default = {
      de = mkOption {
        type = types.enum ["hyprland" "none"];
        default = "none";
      };
      bar = mkOption {
        type = types.enum ["waybar" "aard" "none"];
        default = "none";
      };
      browser = mkOption {
        type = types.enum ["firefox" "zen" "none"];
        default = "none";
      };
      terminal = mkOption {
        type = types.enum ["wezterm" "foot" "kitty" "alacritty" "none"];
        default = "kitty";
      };
      prompt = mkOption {
        type = types.enum ["starship" "oh-my-posh"];
        default = "starship";
      };
      shell = mkOption {
        type = types.enum ["zsh" "fish" "nu"];
        default = "zsh";
      };
    };
  };
}
