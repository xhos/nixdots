{ pkgs, config, ... }: {

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
  # boot-management.enable = true;

  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";
}
