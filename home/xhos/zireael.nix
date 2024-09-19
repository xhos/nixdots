{ inputs, pkgs, lib, config, ... }: {
  theme = "apathy";

  imports = [
    ../../modules/home
  ];

  modules = {
    rofi.enable      = true;
    spicetify.enable = true;
    firefox.enable   = true;
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
