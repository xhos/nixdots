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

  greeter = "autologin";

  users.users.xhos.openssh.authorizedKeys.keyFiles = [./vyverne.pub];

  services.hardware.openrgb.enable = true;
  programs.adb.enable = true;

  security.sudo.extraConfig = ''
    xhos ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/shutdown, /run/current-system/sw/bin/poweroff, /run/current-system/sw/bin/reboot
    xhos ALL=(ALL) NOPASSWD: /usr/bin/shutdown, /usr/bin/poweroff, /usr/bin/reboot
    xhos ALL=(ALL) NOPASSWD: /sbin/shutdown, /sbin/poweroff, /sbin/reboot
  '';
  systemd.tmpfiles.rules = [
    "d /games 0755 xhos users - -"
  ];

  networking.interfaces.enp4s0.wakeOnLan.enable = true;

  boot.kernelParams = ["hid_apple.fnmode=2"];
  boot.supportedFilesystems = ["zfs"];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
