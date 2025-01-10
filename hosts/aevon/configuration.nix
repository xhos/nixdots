{
  pkgs,
  ...
}: {
  imports = [
    ../../modules/nixos
  ];

  networking.hostName = "aevon";
  wsl.defaultUser = "xhos";

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  wsl.enable = true;
}
