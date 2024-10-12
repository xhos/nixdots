{ inputs, pkgs, lib, config, ... }: {
  theme = "tokyo-night-storm";

  imports = [
    ../../modules/home
  ];

  default = {
    de       = "none";
    bar      = "none";
    lock     = "none";
    shell    = "fish";
    prompt   = "starship";
    terminal = "none";
  };
}
