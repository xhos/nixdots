{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];
  
  networking.hostName = "gbook";

  tailscale .enable = false;
  fonts     .enable = true;
  wayland   .enable = true;
  pipewire  .enable = true;
  steam     .enable = true;
}