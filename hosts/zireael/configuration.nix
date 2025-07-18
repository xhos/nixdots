{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "zireael";

  users.users.xhos.openssh.authorizedKeys.keyFiles = [./zireael.pub];

  wayland   .enable = true;
  audio     .enable = true;
  bluetooth .enable = true;
  greetd    .enable = true;
  boot      .enable = true;

  greeter = "sddm";

  hardware.sensor.iio.enable = true; # enables sensors needed for iio-hyprland (screen rotation)

  boot = {
    extraModulePackages = let
      sgbextras = config.boot.kernelPackages.callPackage ../../derivs/samsung-galaxybook-extras.nix {};
    in [
      sgbextras
    ];
    kernelParams = ["i915.force_probe=46a6"]; # https://nixos.wiki/wiki/Intel_Graphics
  };

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver # LIBVA_DRIVER_NAME=iHD
    intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    libvdpau-va-gl
  ];

  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Force intel-media-driver

  services.fprintd.enable = true;
}
