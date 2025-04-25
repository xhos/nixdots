{lib, ...}: {
  options = with lib; {
    wallsDir = mkOption {
      type = types.str;
      default = "";
    };
    theme = mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
    modules = {
      firefox.enable = mkEnableOption "Enable firefox";
      mpd.enable = mkEnableOption "Enable mpd";
      rofi.enable = mkEnableOption "Enable rofi";
      spicetify.enable = mkEnableOption "Enable spicetify";
      discord.enable = mkEnableOption "Enable discord";
      nvidia.enable = mkEnableOption "Enable nvidia specific patches";
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
      lock = mkOption {
        type = types.enum ["hyprlock" "none"];
        default = "none";
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
