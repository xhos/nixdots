{ pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];
  
  networking.hostName = "zireael";

  fonts     .enable = true;
  wayland   .enable = true;
  pipewire  .enable = true;
  steam     .enable = true;

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
