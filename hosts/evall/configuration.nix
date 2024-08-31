{ pkgs, config, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "evall";

  users.users.xhos.openssh.authorizedKeys.keyFiles = [ ./evall.pub ];

  fonts     .enable = false;
  wayland   .enable = false;
  audio     .enable = false;
  bluetooth .enable = false;
  sshserver .enable = true;
  rclone    .enable = false;
  steam     .enable = false;
  firefox   .enable = false;
}
