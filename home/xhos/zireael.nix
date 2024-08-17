{ inputs, pkgs, lib, config, ... }: {
  theme = "verdant";

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
    shell    = "fish";
    prompt   = "starship";
    terminal = "wezterm";
  };
}
