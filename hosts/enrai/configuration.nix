{
  imports = [
    ../../modules/nixos
    ./disko.nix
    ./jellyfin.nix
    ./arr.nix
    ./glance.nix
    ./proton-vpn.nix
  ];

  networking.hostName = "enrai";
  networking.hostId = "8a1e0ee2";
  nixpkgs.hostPlatform = "x86_64-linux";

  impermanence.enable = true;
  headless = true;

  boot.supportedFilesystems = ["zfs"];

  boot.zfs = {
    forceImportRoot = true;
    forceImportAll = true;
    extraPools = ["storage"];
  };

  users.users.root.initialPassword = "temp";

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  users.users.xhos.openssh.authorizedKeys.keyFiles = [./enrai.pub];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
