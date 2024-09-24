{ config, lib, pkgs, callPackage, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "vyverne";

  wayland   .enable = false;
  audio     .enable = true;
  bluetooth .enable = true;
  sshserver .enable = true;
  rclone    .enable = false;
  steam     .enable = true;
  greetd    .enable = false;
  i3        .enable = true;
  xserver   .enable = true;


  # boot.kernelModules = ["adm1021" "coretemp" "nct6775"];

  hardware.opengl.enable = true;

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
