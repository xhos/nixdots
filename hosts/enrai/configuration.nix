{
  imports = [
    ../../modules/nixos
    ./disko.nix
    ./jellyfin.nix
    ./arr.nix
    ./glance.nix
    ./proton-vpn.nix
    ./proxy.nix
    ./incus.nix
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

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.vscode-server.enable = true;

  users.users.xhos.openssh.authorizedKeys.keyFiles = [./enrai.pub];

  services.cloudflared = {
    enable = true;
    tunnels = let
      tunnel-id = "efa05949-86bc-4b7e-8b28-acc3fc97fb08";
    in {
      "${tunnel-id}" = {
        credentialsFile = "/home/xhos/.cloudflared/${tunnel-id}.json";
        ingress = {
          "ssh.xhos.dev" = "ssh://localhost:10022";
        };
        default = "http_status:404";
      };
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
