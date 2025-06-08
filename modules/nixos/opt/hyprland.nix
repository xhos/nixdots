{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.de == "hyprland") {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    xdg.portal.enable = true;
    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };
}
