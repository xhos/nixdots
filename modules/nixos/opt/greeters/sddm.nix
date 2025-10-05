{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf (config.greeter == "sddm") {
    services.displayManager = {
      defaultSession = "hyprland";
      sessionPackages = [pkgs.hyprland];
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "where_is_my_sddm_theme";
      };
    };

    environment.systemPackages = with pkgs; [
      (callPackage ../../../../derivs/where-is-my-sddm-theme.nix {
        qtgraphicaleffects = pkgs.libsForQt5.qt5.qtgraphicaleffects;
        themeConfig.General = {
          passwordAllowEmpty = true;
          passwordCursorColor = "#fff";
          passwordFontSize = 32;
        };
      })
    ];
  };
}
