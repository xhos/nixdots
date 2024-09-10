{ pkgs, config, ... }: {

  imports = [
    ../../modules/nixos
  ];

  networking.hostName = "aevon";

  # users.users.xhos.openssh.authorizedKeys.keyFiles = [ ./zireael.pub ];

  fonts     .enable = false;
  wayland   .enable = false;
  audio     .enable = false;
  bluetooth .enable = false;
  sshserver .enable = false;
  rclone    .enable = false;
  steam     .enable = false;
  firefox   .enable = false;
}
