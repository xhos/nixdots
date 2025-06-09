{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  theme = "tokyo-night-storm";

  imports = [
    ../../modules/home
  ];

  home = {
    username = "xhos";
    homeDirectory = "/home/xhos";
    stateVersion = "25.05";
  };

  default = {
    de = "none";
    bar = "none";
    lock = "none";
    shell = "fish";
    prompt = "starship";
    terminal = "none";
  };
}
