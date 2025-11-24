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

  greeter = "yawn";
  systemd.tmpfiles.rules = [
    "z /sys/class/firmware-attributes/samsung-galaxybook/attributes/block_recording/current_value 0660 xhos users -"
  ];
  hardware.sensor.iio.enable = true; # screen rotation sensor
  # boot.kernelPackages = pkgs.linuxPackages_;
  services.fprintd.enable = true;
}
