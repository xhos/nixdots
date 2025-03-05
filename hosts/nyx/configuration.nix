{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix"
  ];

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # isoImage.forceTextMode = true;

  environment.systemPackages = with pkgs; [
    git
    disko
    parted
    neovim
    vscode
  ];
}
