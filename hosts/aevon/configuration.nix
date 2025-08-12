{pkgs, ...}: {
  imports = [../../modules/nixos];

  vm.enable = true;

  wsl.enable = true;
  wsl.defaultUser = "xhos";

  networking.hostName = "aevon";
  nixpkgs.hostPlatform = "x86_64-linux";

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}
