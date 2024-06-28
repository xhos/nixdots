{ pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../derivs/gbook-driver.nix
  ];
  
  networking.hostName = "zireael";

  users.users.xhos.openssh.authorizedKeys.keyFiles = [ ./zireael.pub ];

  fonts     .enable = true;
  wayland   .enable = true;
  audio     .enable = true;
  bluetooth .enable = true;
  sshserver .enable = true;

  # Intel specific stuff, not sure if needed but why not
  boot.kernelParams = [ "i915.force_probe=46a6" ]; # https://nixos.wiki/wiki/Intel_Graphics
  
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver # LIBVA_DRIVER_NAME=iHD
    intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
  ];
  
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver
  
}
