{ inputs, pkgs, lib, config, ... }: {
  theme = "apathy";

  imports = [
    ../../modules/home/opt/shells/fish
  ];

  # modules = {
  #   rofi.enable      = false;
  #   hyprland.enable  = false;
  #   spicetify.enable = false;
  #   firefox.enable   = false;
  # };

  # default = {
  #   de       = "none";
  #   bar      = "none";
  #   lock     = "none";
  #   shell    = "fish";
  #   prompt   = "starship";
  #   terminal = "none";
  # };
}
