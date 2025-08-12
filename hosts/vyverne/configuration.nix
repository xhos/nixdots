{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ./disko.nix
  ];

  networking.hostName = "vyverne";
  networking.hostId = "9a7bef04";

  impermanence.enable = true;
  wayland     .enable = true;
  audio       .enable = true;
  bluetooth   .enable = true;
  steam       .enable = true;
  greetd      .enable = true;
  nvidia      .enable = true;
  vm          .enable = true;
  ai          .enable = true;
  boot        .enable = true;

  greeter = "sddm";

  services.hardware.openrgb.enable = true;
  programs.adb.enable = true;

  boot.kernelParams = ["hid_apple.fnmode=2"];
  boot.supportedFilesystems = ["zfs"];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
