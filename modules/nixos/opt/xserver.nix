{ config, lib, ...}: {
  config = lib.mkIf config.xserver.enable {
    services.xserver.enable = true;
  };
}