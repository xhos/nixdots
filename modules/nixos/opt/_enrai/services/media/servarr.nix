{
  lib,
  config,
  ...
}: {
  services = {
    prowlarr.enable = true;
    sonarr.enable = true;
    radarr.enable = true;
    bazarr.enable = true;
    flaresolverr.enable = true;
  };

  _enrai.exposedServices.prowlarr.port = config.services.prowlarr.settings.server.port;
  _enrai.exposedServices.sonarr.port = config.services.sonarr.settings.server.port;
  _enrai.exposedServices.radarr.port = config.services.radarr.settings.server.port;
  _enrai.exposedServices.bazarr.port = config.services.bazarr.listenPort;
  _enrai.exposedServices.flaresolverr.port = config.services.flaresolverr.port;

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

  services.recyclarr = {
    enable = true;
    schedule = "daily";

    configuration = {
      sonarr.anime = {
        base_url = "http://127.0.0.1:${toString config.services.sonarr.settings.server.port}";
        api_key = "5f0de5bb92d0459f911923f1d3d3a1ab";
        include = [
          {template = "sonarr-quality-definition-anime";}
          {template = "sonarr-v4-quality-profile-anime";}
          {template = "sonarr-v4-custom-formats-anime";}
        ];
        custom_formats = [
          {
            trash_ids = ["d6e9318c875905d6cfb5bee961afcea9"];
            assign_scores_to = [
              {
                name = "Remux-1080p - Anime";
                score = -10000;
              }
            ];
          }
        ];
      };

      radarr.movies = {
        base_url = "http://127.0.0.1:${toString config.services.radarr.settings.server.port}";
        api_key = "6c0988510f55474396c72be61a7f59d6";

        include = [
          {template = "radarr-quality-definition-movie";}
          {template = "radarr-quality-profile-hd-bluray-web";}
          {template = "radarr-custom-formats-hd-bluray-web";}
        ];
      };
    };
  };
}
