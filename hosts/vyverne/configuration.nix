{config, pkgs, inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "vyverne";

  wayland   .enable = true;
  audio     .enable = true;
  bluetooth .enable = true;
  sshserver .enable = false;
  rclone    .enable = false;
  steam     .enable = true;
  greetd    .enable = false;

  de = "plasma";

  # Nvidia related
  boot.kernelModules = ["adm1021" "coretemp" "nct6775" "i2c-dev" "i2c-piix4"];
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Fan control
  programs.coolercontrol = {
    enable = true;
    nvidiaSupport = true;
  };

  # RGB control
  services.hardware.openrgb.enable = true;

  # https://nixos.wiki/wiki/OBS_Studio
  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  boot.extraModprobeConfig = ''options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1'';
}
