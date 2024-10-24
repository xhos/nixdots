{config, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "vyverne";

  wayland   .enable = true;
  audio     .enable = true;
  bluetooth .enable = true;
  sshserver .enable = true;
  rclone    .enable = false;
  steam     .enable = true;
  greetd    .enable = true;
  i3        .enable = true;
  xserver   .enable = true;
  hyprland  .enable = true;

  # boot.kernelModules = ["adm1021" "coretemp" "nct6775"];
  #   hardware.opengl.enable = true;

  services.xserver.videoDrivers = ["nvidia"];

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  programs.coolercontrol = {
    enable = true;
    nvidiaSupport = true;
  };
}
