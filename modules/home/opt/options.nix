{ lib, ... }: {
  options = with lib; {
    modules = {
      firefox.enable   = mkEnableOption "Enable firefox";
      mpd.enable       = mkEnableOption "Enable mpd";
      rofi.enable      = mkEnableOption "Enable rofi";
      spicetify.enable = mkEnableOption "Enable spicetify";
      discord.enable   = mkEnableOption "Enable discord";
    };

    default = {
      de = mkOption {
        type = types.enum ["hyprland" "none"];
        default = "hyprland";
      };
      bar = mkOption {
        type = types.enum ["waybar" "none"];
        default = "waybar";
      };
      browser = mkOption {
        type = types.enum ["firefox" "none"];
        default = "firefox";
      };
      terminal = mkOption {
        type = types.enum ["wezterm" "foot" "kitty" "alacritty" "none"];
        default = "alacritty";
      };
      lock = mkOption {
        type = types.enum ["hyprlock" "none"];
        default = "hyprlock";
      };
      prompt = mkOption {
        type = types.enum ["starship" "oh-my-posh"];
        default = "oh-my-posh";
      };
      shell = mkOption {
        type = types.enum ["zsh" "fish" "nu"];
        default = "fish";
      };
    };
  };
}
