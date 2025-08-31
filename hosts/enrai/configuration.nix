{
  imports = [
    ../../modules/nixos
    ./disko.nix
    ./jellyfin.nix
  ];

  networking.hostName = "enrai";
  networking.hostId = "8a1e0ee2";
  nixpkgs.hostPlatform = "x86_64-linux";

  impermanence.enable = true;
  headless = true;

  boot.supportedFilesystems = ["zfs"];

  # Fix: Explicitly configure ZFS pool imports
  boot.zfs = {
    forceImportRoot = true; # Force import for first boot after disko
    forceImportAll = true; # Force import ALL pools on first boot
    extraPools = ["storage"]; # Explicitly import the storage pool
  };

  # CRITICAL: Set a root password so you can login
  users.users.root.initialPassword = "temp";

  # Alternative fix if above doesn't work:
  # boot.zfs.requestEncryptionCredentials = false;
  # systemd.services.zfs-import-storage = {
  #   wantedBy = ["zfs-import.target"];
  #   after = ["zfs-import.target"];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.zfs}/bin/zpool import storage";
  #   };
  # };

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  users.users.xhos.openssh.authorizedKeys.keyFiles = [./enrai.pub];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
