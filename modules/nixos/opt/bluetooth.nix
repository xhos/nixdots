{
  config,
  lib,
  ...
}: {
  options.bluetooth.enable = lib.mkEnableOption "Bluetooth support";

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
  };
}
