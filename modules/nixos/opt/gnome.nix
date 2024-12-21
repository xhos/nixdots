{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.default.de == "gnome") {    
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    services.displayManager.defaultSession = "gnome";
  };
}