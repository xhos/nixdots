{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ./disko.nix
  ];

  networking.hostName = "zireael";
  networking.hostId = "5ca416d5";

  boot.supportedFilesystems = ["zfs"];

  users.users.xhos.openssh.authorizedKeys.keyFiles = [./zireael.pub];

  impermanence.enable = true;
  bluetooth   .enable = true;
  greetd      .enable = true;
  audio       .enable = true;
  boot        .enable = true;

  greeter = "sddm";

  hardware.sensor.iio.enable = true; # screen rotation sensor
  boot.kernelPackages = pkgs.linuxPackages_6_16;
  services.fprintd.enable = true;
}
