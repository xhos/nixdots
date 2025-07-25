{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./binds.nix
    ./options.nix
    ./rules.nix
    ./hyprspace.nix
    ./pkgs.nix
    # ./osk.nix
  ];

  config = lib.mkIf (config.default.de == "hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;
      plugins = with pkgs.hyprlandPlugins; [
        hyprgrass
        hypr-dynamic-cursors
        hyprsplit
      ];

      xwayland.enable = true;
    };

    services.hyprpaper.enable = true;

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      configPackages = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };

    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = ["graphical-session-pre.target"];
      };
    };
  };
}
