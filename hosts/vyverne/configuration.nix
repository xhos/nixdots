{ config, lib, pkgs, callPackage, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "vyverne";

  # users.users.xhos.openssh.authorizedKeys.keyFiles = [ ./vyverne.pub ];

  fonts          .enable = true;
  wayland        .enable = true;
  audio          .enable = true;
  bluetooth      .enable = true;
  sshserver      .enable = true;
  rclone         .enable = true;
  steam          .enable = true;
  boot-management.enable = true;

  boot.kernelModules = ["adm1021" "coretemp" "nct6775"];

  hardware.opengl.enable = true;

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
