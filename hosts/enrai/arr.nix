{lib, ...}: {
  services = {
    qbittorrent = {
      enable = true;
      user = "qbittorrent";
      group = "media";
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
    };

    sonarr = {
      enable = true;
      openFirewall = true;
    };

    bazarr = {
      enable = true;
      openFirewall = true;
    };

    readarr = {
      enable = true;
      openFirewall = true;
    };

    flaresolverr = {
      enable = true;
      openFirewall = true;
    };
  };

  users = let
    mediaServices = ["sonarr" "bazarr" "prowlarr" "readarr"];
  in {
    users = lib.genAttrs mediaServices (name: {
      isSystemUser = true;
      group = name;
      extraGroups = ["media"];
    });
    groups = lib.genAttrs (mediaServices ++ ["media"]) (_: {});
  };

  systemd.tmpfiles.rules = [
    "d /storage/media 0775 root media -"
    "d /storage/media/cache 0755 root root -"
    "d /storage/media/cache/jellyfin 0755 jellyfin jellyfin -"
  ];
}
