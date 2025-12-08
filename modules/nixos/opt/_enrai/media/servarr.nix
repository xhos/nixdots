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

    radarr = {
      enable = true;
      openFirewall = true;
    };

    bazarr = {
      enable = true;
      openFirewall = true;
    };

    flaresolverr = {
      enable = true;
      openFirewall = true;
    };
  };

  users = let
    mediaServices = ["sonarr" "radarr" "bazarr" "prowlarr"];
  in {
    users = lib.genAttrs mediaServices (name: {
      isSystemUser = true;
      group = name;
      extraGroups = ["media"];
    });
    groups = lib.genAttrs (mediaServices ++ ["media"]) (_: {});
  };

  # unset dynamic user stuff which makes it difficult to persist
  systemd.services.prowlarr.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "prowlarr";
    Group = "prowlarr";
  };

  # systemd.services.radarr.serviceConfig = {
  #   DynamicUser = lib.mkForce false;
  #   User = "radarr";
  #   Group = "radarr";
  # };

  systemd.tmpfiles.rules = [
    "d /storage/media 0775 root media -"
    "d /storage/media/cache 0755 root root -"
    "d /storage/media/cache/jellyfin 0755 jellyfin jellyfin -"
  ];
}
