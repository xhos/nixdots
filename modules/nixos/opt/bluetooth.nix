{ pkgs, config, lib, ... }: {
  config = lib.mkIf config.bluetooth.enable {
    hardware = {
      bluetooth.enable = true;
      bluetooth.input.General = { ClassicBondedOnly = false; };
    };
    services.blueman.enable = true;
  };
}