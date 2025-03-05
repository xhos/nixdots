{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = lib.mkIf (config.de == "hyprland") true;
  };
}
