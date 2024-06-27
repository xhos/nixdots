{ inputs, pkgs, lib, config, ... }: {
  theme = "tokyo-night-dark";

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
