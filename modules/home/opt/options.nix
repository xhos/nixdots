{lib, ...}: {
  options = {
    modules = {
      firefox.enable   = lib.mkEnableOption "Enable firefox";
      hyprland.enable  = lib.mkEnableOption "Enable hyprland";
      lf.enable        = lib.mkEnableOption "Enable lf";
      mpd.enable       = lib.mkEnableOption "Enable mpd";
      ncmpcpp.enable   = lib.mkEnableOption "Enable ncmp";
      rofi.enable      = lib.mkEnableOption "Enable rofi";
      spicetify.enable = lib.mkEnableOption "Enable spicetify";
      wezterm.enable   = lib.mkEnableOption "Enable wezterm";
      kitty.enable     = lib.mkEnableOption "Enable kitty";
    };

    default = {
      de = lib.mkOption {
        type = lib.types.enum ["hyprland"];
        default = "hyprland";
      };
      bar = lib.mkOption {
        type = lib.types.enum ["ags" "waybar"];
        default = "ags";
      };
      browser = lib.mkOption {
        type = lib.types.enum ["firefox"];
        default = "firefox";
      };
      terminal = lib.mkOption {
        type = lib.types.enum ["wezterm" "foot" "kitty"];
        default = "foot";
      };
      lock = lib.mkOption {
        type = lib.types.enum ["hyprlock"];
        default = "hyprlock";
      };
      prompt = lib.mkOption {
        type = lib.types.enum ["starship" "oh-my-posh"];
        default = "oh-my-posh";
      };
      shell = lib.mkOption {
        type = lib.types.enum ["zsh" "fish" "nushell"];
        default = "zsh";
      };
    };
  };
}
