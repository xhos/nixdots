{ config, libs, pkgs, ... }:

{
  # environment.systemPackages = with pkgs; [
  #   hyprland
  #   wl-clipboard
  #   xdg-utils
  #   vesktop
  # ];

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gtk
  #     xdg-desktop-portal-wlr
  #     xdg-desktop-portal-hyprland
  #   ];
  # };

  # programs = {
  #   hyprland = {
  #     enable = true;
  #   };
  #   xwayland = {
  #     enable = true;
  #   };
  # };
  xdg.desktopEntries = {
      spotify = {
          name = "Spotify";
          genericName = "Spotify";
          exec = "spotify --enable-features=UseOzonePlatform --ozone-platform=wayland";
          terminal = false;
          categories = [ "Application" ];
          };
  }
}
