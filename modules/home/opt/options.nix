{lib, ...}: {
  options = {
    modules = {
      firefox.enable   = lib.mkEnableOption "Enable firefox";
      lf.enable        = lib.mkEnableOption "Enable lf";
      mpd.enable       = lib.mkEnableOption "Enable mpd";
      rofi.enable      = lib.mkEnableOption "Enable rofi";
      spicetify.enable = lib.mkEnableOption "Enable spicetify";
      wezterm.enable   = lib.mkEnableOption "Enable wezterm";
      kitty.enable     = lib.mkEnableOption "Enable kitty";
      discord.enable    = lib.mkEnableOption "Enable discord";
    };

    default = {
      de = lib.mkOption {
        type = lib.types.enum ["hyprland" "none"];
        default = "hyprland";
      };
      bar = lib.mkOption {
        type = lib.types.enum ["waybar" "none"];
        default = "waybar";
      };
      browser = lib.mkOption {
        type = lib.types.enum ["firefox" "none"];
        default = "firefox";
      };
      terminal = lib.mkOption {
        type = lib.types.enum ["wezterm" "foot" "kitty" "alacritty" "none"];
        default = "foot";
      };
      lock = lib.mkOption {
        type = lib.types.enum ["hyprlock" "none"];
        default = "hyprlock";
      };
      prompt = lib.mkOption {
        type = lib.types.enum ["starship" "oh-my-posh"];
        default = "oh-my-posh";
      };
      shell = lib.mkOption {
        type = lib.types.enum ["zsh" "fish" "nu"];
        default = "fish";
      };
    };
  };
}
