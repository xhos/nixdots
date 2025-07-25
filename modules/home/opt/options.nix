{lib, ...}: {
  options = with lib; {
    modules = {
      firefox.enable = mkEnableOption "Enable firefox";
      mpd.enable = mkEnableOption "Enable mpd";
      rofi.enable = mkEnableOption "Enable rofi";
      spicetify.enable = mkEnableOption "Enable spicetify";
      discord.enable = mkEnableOption "Enable discord";
      nvidia.enable = mkEnableOption "Enable nvidia specific patches";
      secrets.enable = mkEnableOption "Enable secrets management";
      telegram.enable = mkEnableOption "Enable telegram";
      whisper.enable = mkEnableOption "Enable whisper";
    };

    mainMonitor = mkOption {
      type = types.str;
      description = "main monitor of the system, used for hyprlock";
    };

    hyprland = {
      hyprspace.enable = mkEnableOption "Enable hyprland overview plugin";
    };

    default = {
      de = mkOption {
        type = types.enum ["hyprland" "plasma" "none"];
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
