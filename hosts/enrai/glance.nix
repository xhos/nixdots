let
  serverIP = "10.0.0.10";
in {
  services.glance = {
    enable = true;
    openFirewall = true;

    settings = {
      server = {
        port = 3000;
        host = "0.0.0.0";
      };

      pages = [
        {
          name = "Media Server";
          columns = [
            {
              size = "full";
              widgets = [
                {
                  type = "clock";
                  hour-format = "24h";
                  timezones = [
                    {
                      timezone = "Local";
                      label = "Local";
                    }
                  ];
                }
                {
                  type = "bookmarks";
                  groups = [
                    {
                      title = "Media Services";
                      links = [
                        {
                          title = "Jellyfin";
                          url = "http://${serverIP}:8096";
                        }
                      ];
                    }
                    {
                      title = "Download Management";
                      links = [
                        {
                          title = "qBittorrent";
                          url = "http://192.168.15.1:8080";
                        }
                        {
                          title = "Sonarr";
                          url = "http://${serverIP}:8989";
                        }
                        {
                          title = "Prowlarr";
                          url = "http://${serverIP}:9696";
                        }
                        {
                          title = "Bazarr";
                          url = "http://${serverIP}:6767";
                        }
                      ];
                    }
                    {
                      title = "Anime Resources";
                      links = [
                        {
                          title = "MyAnimeList";
                          url = "https://myanimelist.net";
                        }
                        {
                          title = "Nyaa";
                          url = "https://nyaa.si";
                        }
                        {
                          title = "AniDB";
                          url = "https://anidb.net";
                        }
                      ];
                    }
                  ];
                }
                {
                  type = "monitor";
                  cache = "1m";
                  title = "Service Status";
                  sites = [
                    {
                      title = "Jellyfin";
                      url = "http://${serverIP}:8096";
                    }
                    {
                      title = "qBittorrent";
                      url = "http://${serverIP}:8080";
                    }
                    {
                      title = "Sonarr";
                      url = "http://${serverIP}:8989";
                    }
                    {
                      title = "Prowlarr";
                      url = "http://${serverIP}:9696";
                    }
                    {
                      title = "Bazarr";
                      url = "http://${serverIP}:6767";
                    }
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
