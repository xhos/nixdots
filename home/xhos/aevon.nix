{ inputs, pkgs, lib, config, ... }: {
  theme = "apathy";

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
