{ inputs, pkgs, lib, config, ... }: {
  theme = "tokyodark";

  imports = [
    ../../modules/home
  ];

  modules = {
    rofi.enable      = false;
    hyprland.enable  = false;
    spicetify.enable = false;
  };

  default = {
    de       = "none";
    bar      = "none";
    lock     = "none";
    shell    = "fish";
    prompt   = "starship";
    terminal = "none";
  };
}
