{ inputs, pkgs, lib, config, ... }: {
  theme = "greenscreen";

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
    bar      = "ags";
    lock     = "hyprlock";
    shell    = "nu";
    prompt   = "starship";
    terminal = "wezterm";
  };
}
