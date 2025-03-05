{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.de == "gnome") {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
    };

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      ghostty
    ];

    services.displayManager.defaultSession = "gnome";
  };
}
