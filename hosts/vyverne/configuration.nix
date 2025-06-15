{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ./disko.nix
  ];

  networking.hostName = "vyverne";
  networking.hostId = "9a7bef04";

  programs.fuse.userAllowOther = true;
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos" # nixos config
      "/var/lib/nixos" # other nixos state
      "/etc/NetworkManager/system-connections" # wifi
      "/var/lib/bluetooth" # bluetooth
      "/var/lib/libvirt" # virt-manager
    ];
    files = [
      "/etc/machine-id"
    ];
  };
  # # 2) Systemd: bind /persist/games → /games _after_ ZFS mounts it
  # fileSystems."/games" = {
  #   device = "/persist/games";
  #   fsType = "none"; # a bind mount
  #   options = [
  #     "bind"
  #     "x-systemd.requires-mounts-for=/persist/games"
  #   ];
  #   neededForBoot = true;
  # }; # ensures /persist/games is mounted first, then bound
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = ["defaults" "size=25%" "mode=755"];
  };

  # systemd.tmpfiles.rules = [
  #   # d = create directory if missing; here it also chowns+chmods it
  #   "d /persist/games 0755 xhos xhos -"
  # ];

  systemd.tmpfiles.rules = [
    "d /games 0755 xhos xhos -"
  ];

  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;

  wayland   .enable = true;
  audio     .enable = true;
  bluetooth .enable = true;
  # sshserver .enable = false;
  # rclone    .enable = true;
  steam     .enable = true;
  greetd    .enable = true;
  nvidia    .enable = true;
  vm        .enable = true;
  # ai        .enable = true;
  # obs       .enable = true;
  boot      .enable = true;

  de = "hyprland";
  greeter = "tuigreet";

  # RGB control
  services.hardware.openrgb.enable = true;

  programs.adb.enable = true;

  boot.kernelParams = ["hid_apple.fnmode=2"];
  boot.supportedFilesystems = ["zfs"];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
