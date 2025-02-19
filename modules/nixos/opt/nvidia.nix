{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.nvidia.enable {
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = true;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware.graphics = {
      enable = true;
    };
  };
}
