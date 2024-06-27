{ inputs, pkgs, lib, config, ... }: {
  theme = "tokyo-night-dark";

  imports = [
    ../../modules/home
  ];

  modules = {
    hyprland.enable  = true;
    rofi.enable      = true;
    spicetify.enable = true;
  };

  default = {
    de       = "hyprland";
    bar      = "ags";
    lock     = "hyprlock";
    shell    = "nu";
    prompt   = "starship";
    terminal = "wezterm";
  };
}
