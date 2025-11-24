{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./binds.nix
    ./options.nix
    ./rules.nix
    ./hyprspace.nix
    ./pkgs.nix
    ./monitors.nix
    # ./osk.nix
  ];

  config = lib.mkIf (config.de == "hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      plugins = [
        inputs.hyprgrass.packages.${pkgs.stdenv.hostPlatform.system}.hyprgrass
        inputs.hypr-dynamic-cursors.packages.${pkgs.stdenv.hostPlatform.system}.hypr-dynamic-cursors
        inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplit
      ];

      xwayland.enable = true;
    };

    services.hyprpaper.enable = true;

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      configPackages = with pkgs; [
        # xdg-desktop-portal-hyprland
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
