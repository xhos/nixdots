{
  imports = [
    ../../modules/nixos
    ./disko.nix
  ];

  networking.hostName = "enrai";
  networking.hostId = "8a1e0ee2";
  nixpkgs.hostPlatform = "x86_64-linux";

  impermanence.enable = true;
  headless = true;

  boot.supportedFilesystems = ["zfs"];
  
  boot.zfs = {
    forceImportRoot = false;  
    extraPools = ["storage"];
  };
  
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  users.users.xhos.openssh.authorizedKeys.keyFiles = [./enrai.pub];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
