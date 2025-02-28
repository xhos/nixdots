{
  config,
  lib,
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

    services.displayManager.defaultSession = "gnome";
  };
}
