{modulesPath, ...}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../../modules/nixos
  ];

  networking.hostName = "nyx";

  wayland   .enable = true;
  audio     .enable = true;
  greetd    .enable = true;
  nvidia    .enable = true;

  de = "hyprland";
  greeter = "tuigreet";

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # isoImage.forceTextMode = true;
}
