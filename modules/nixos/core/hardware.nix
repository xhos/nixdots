# {
#   hardware = {
#     bluetooth.enable = true;
#     bluetooth.input.General = {ClassicBondedOnly = false;};
#     opengl = {
#       enable = true;
#       driSupport32Bit = true;
#     };
#   };
# }
{pkgs,...}:
{
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware = {
    bluetooth.enable = true;
    bluetooth.input.General = {ClassicBondedOnly = false;};
    
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        libvdpau-va-gl
      ];
    };
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver
}
