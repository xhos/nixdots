{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.default.de == "plasma") {    
    services = {
      xserver.enable = true;
      desktopManager.plasma6.enable = true;
      displayManager = {
        defaultSession = "plasma";
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
    };
  };
}