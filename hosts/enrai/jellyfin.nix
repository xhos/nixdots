{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
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
