{pkgs, ...}: {
  imports = [../../modules/nixos];

  networking.hostName = "aevon";
  wsl.defaultUser = "xhos";

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  wsl.enable = true;
}
