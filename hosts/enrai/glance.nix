{lib, ...}: {
  # unset dynamic user stuff which makes it difficult to persist
  systemd.services.glance.serviceConfig = {
    StateDirectory = lib.mkForce null;
    DynamicUser = lib.mkForce false;
    User = "glance";
    Group = "glance";
  };

  users.users.glance = {
    isSystemUser = true;
    group = "glance";
  };
  users.groups.glance = {};

  services.glance = {
    enable = true;
    openFirewall = true;

    settings = let
      serverIP = "10.0.0.10";
    in {
      pages = [
        {
          name = "Home";
          head-widgets = [
            {
              type = "markets";
              hide-header = true;
              markets = [
                {
                  symbol = "SPY";
                  name = "S&P 500";
                }
                {
                  symbol = "BTC-USD";
                  name = "Bitcoin";
                }
                {
                  symbol = "NVDA";
                  name = "NVIDIA";
                }
                {
                  symbol = "AAPL";
                  name = "Apple";
                }
                {
                  symbol = "MSFT";
                  name = "Microsoft";
                }
              ];
            }
          ];

          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "clock";
                  hide-header = true;
                  hour-format = "24h";
                  timezones = [
                    {
                      timezone = "Europe/Lisbon";
                      label = "lisbon";
                    }
                    {
                      timezone = "Europe/Berlin";
                      label = "berlin";
                    }
                    {
                      timezone = "Europe/Kiev";
                      label = "lviv";
                    }
                    {
                      timezone = "Europe/Moscow";
                      label = "moscow";
                    }
                    {
                      timezone = "Asia/Tokyo";
                      label = "tokyo";
                    }
                    {
                      timezone = "America/Los_Angeles";
                      label = "los angeles";
                    }
                  ];
                }
                {
                  type = "calendar";
                  hide-header = true;
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "hacker-news";
                  hide-header = true;
                  limit = 15;
                  collapse-after = 5;
                }
                {
                  type = "bookmarks";
                  hide-header = true;
                  groups = [
                    {
                      title = "stuff i need";
                      links = [
                        {
                          title = "jellyfin";
                          url = "http://${serverIP}:8096";
                          icon = "/assets/jellyfin.png";
                        }
                        {
                          title = "sonarr";
                          url = "http://${serverIP}:8989";
                          icon = "/assets/sonarr.png";
                        }
                        {
                          title = "wakapi";
                          url = "https://wakapi.xhos.dev";
                          icon = "/assets/wakapi.png";
                        }
                        {
                          title = "zipline";
                          url = "https://pics.xhos.dev";
                          icon = "/assets/wakapi.png";
                        }
                        {
                          title = "home assistant";
                          url = "http://${serverIP}:8123";
                          icon = "/assets/home-assistant.png";
                        }
                      ];
                    }
                    {
                      title = "other stuff";
                      links = [
                        {
                          title = "qbittorrent";
                          url = "http://${serverIP}:8080";
                          icon = "/assets/qbittorrent.png";
                        }
                        {
                          title = "prowlarr";
                          url = "http://${serverIP}:9696";
                          icon = "/assets/prowlarr.png";
                        }
                        {
                          title = "bazarr";
                          url = "http://${serverIP}:6767";
                          icon = "/assets/bazarr.png";
                        }
                        {
                          title = "readarr";
                          url = "http://${serverIP}:6767";
                          icon = "/assets/readarr.png";
                        }
                        {
                          title = "Bazarr";
                          url = "http://${serverIP}:6767";
                          icon = "/assets/bazarr.png";
                        }
                      ];
                    }
                  ];
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "weather";
                  hide-header = true;
                  units = "metric";
                  hour-format = "24h";
                  location = "Toronto, Canada";
                }
                {
                  type = "custom-api";
                  title = "Air Quality";
                  hide-header = true;
                  cache = "10m";
                  url = "https://api.waqi.info/feed/geo:43.70011;-79.4163/?token=c1c138444a58023ceec2ac8ed53000041da15ffc";
                  template = ''
                    {{ $aqi := printf "%03s" (.JSON.String "data.aqi") }}
                    {{ $aqiraw := .JSON.String "data.aqi" }}
                    {{ $updated := .JSON.String "data.time.iso" }}
                    {{ $humidity := .JSON.String "data.iaqi.h.v" }}
                    {{ $ozone := .JSON.String "data.iaqi.o3.v" }}
                    {{ $pm25 := .JSON.String "data.iaqi.pm25.v" }}
                    {{ $pressure := .JSON.String "data.iaqi.p.v" }}

                    <div class="flex justify-between">
                      <div class="size-h5">
                        {{ if le $aqi "050" }}
                          <div class="color-positive">Good air quality</div>
                        {{ else if le $aqi "100" }}
                          <div class="color-primary">Moderate air quality</div>
                        {{ else }}
                          <div class="color-negative">Bad air quality</div>
                        {{ end }}
                      </div>
                    </div>

                    <div class="color-highlight size-h2">AQI: {{ $aqiraw }}</div>

                    <div class="margin-block-2">
                      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                      </div>

                    </div>
                  '';
                }
                {
                  type = "monitor";
                  style = "compact";
                  hide-header = true;
                  title = "service status";
                  sites = [
                    {
                      title = "jellyfin";
                      url = "http://${serverIP}:8096";
                    }
                    {
                      title = "qbittorrent";
                      url = "http://192.168.15.1:8080/";
                    }
                    {
                      title = "sonarr";
                      url = "http://${serverIP}:8989";
                    }
                    {
                      title = "prowlarr";
                      url = "http://${serverIP}:9696";
                    }
                    {
                      title = "bazarr";
                      url = "http://${serverIP}:6767";
                    }
                    {
                      title = "readarr";
                      url = "http://${serverIP}:8787";
                    }
                    {
                      title = "flaresolverr";
                      url = "http://${serverIP}:8191";
                    }
                    {
                      title = "home assistant";
                      url = "http://${serverIP}:8123";
                    }
                    {
                      title = "wakapi";
                      url = "https://wakapi.xhos.dev";
                    }
                    {
                      title = "zipline";
                      url = "https://pics.xhos.dev";
                    }
                  ];
                }
                {
                  type = "server-stats";
                  hide-header = true;
                  servers = [
                    {
                      type = "local";
                      name = "resources";
                    }
                  ];
                }
              ];
            }
          ];
        }
      ];

      server = {
        host = "0.0.0.0";
        port = 3000;
        assets-path = "/home/xhos/Pictures/glance-assets";
      };

      branding = {
        hide-footer = true;
      };
    };
  };
}
