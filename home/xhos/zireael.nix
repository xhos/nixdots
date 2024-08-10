{ inputs, pkgs, lib, config, ... }: {
  theme = "catppuccin-macchiato";

  imports = [
    ../../modules/home
  ];

  modules = {
    rofi.enable      = true;
    hyprland.enable  = true;
    spicetify.enable = true;
  };

  default = {
    de       = "hyprland";
    bar      = "waybar";
    lock     = "hyprlock";
    shell    = "nu";
    prompt   = "starship";
    terminal = "wezterm";
  };
}
