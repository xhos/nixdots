{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.de == "plasma") {
    programs.dconf.enable = true;
    services = {
      xserver.enable = false;
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
