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
      "/etc/ssh" # ssh keys1
      "/var/lib/nixos" # other nixos state
      "/etc/NetworkManager/system-connections" # wifi
      "/var/lib/bluetooth" # bluetooth
      "/var/lib/libvirt" # virt-manager
      "/var/lib/private/ollama" # ollama models
      {
        directory = "/home/xhos/.steam";
        user = "xhos";
        group = "users";
        mode = "0755";
      }
      {
        directory = "/home/xhos/.local/share/Steam";
        user = "xhos";
        group = "users";
        mode = "0755";
      }
    ];
    files = [
      "/etc/machine-id"
      "/var/cache/tuigreet/lastuser"
    ];
  };

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = ["defaults" "size=25%" "mode=755"];
  };

  systemd.tmpfiles.rules = [
    "d /games 0755 xhos users - -"
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
  ai        .enable = true;
  boot      .enable = true;

  greeter = "sddm";

  services.hardware.openrgb.enable = true;
  programs.adb.enable = true;

  boot.kernelParams = ["hid_apple.fnmode=2"];
  boot.supportedFilesystems = ["zfs"];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
