{ config, lib, ... }: {
  config = lib.mkIf config.i3.enable {
    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };
    services.displayManager = {
      defaultSession = "none+i3";
    };
  };
}