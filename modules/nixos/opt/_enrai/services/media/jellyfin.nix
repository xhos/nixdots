{pkgs, ...}: {
  _enrai.exposedServices.jellyfin.port = 8096;

  services.jellyfin = {
    enable = true;
    cacheDir = "/storage/media/cache/jellyfin";
  };

  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
    ];
  };

  users = {
    groups.media = {};
    users = {
      jellyfin.extraGroups = ["video" "media"];
      xhos.extraGroups = ["media"];
    };
  };
}
