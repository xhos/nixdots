{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    # settings =  with config.lib.stylix.colors; {
    #   background_opacity = "0.2";
    #   foreground = "#${base08}";
    #   background = "#${base01}";
    # };
  };
}