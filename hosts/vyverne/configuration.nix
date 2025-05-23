{config, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "vyverne";

  wayland   .enable = true;
  audio     .enable = true;
  bluetooth .enable = true;
  sshserver .enable = false;
  rclone    .enable = true;
  steam     .enable = true;
  greetd    .enable = true;
  nvidia    .enable = true;
  vm        .enable = true;
  ai        .enable = true;
  obs       .enable = true;

  de = "hyprland";
  greeter = "tuigreet";

  # RGB control
  services.hardware.openrgb.enable = true;

  boot.kernelParams = ["hid_apple.fnmode=2"];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
