{
  lib,
  config,
  ...
}: let
  enraiIP = "10.0.0.10";
  domain = "xhos.dev";

  services = {
    "adguard" = config.services.adguardhome.port;
    "bazarr" = config.services.bazarr.listenPort;
    "glance" = config.services.glance.settings.server.port;
    "ha" = 8123;
    "jellyfin" = 8096;
    "prowlarr" = config.services.prowlarr.settings.server.port;
    "proxmox" = 8006;
    "qbit" = config.services.qbittorrent.webuiPort;
    "sonarr" = config.services.sonarr.settings.server.port;
  };

  mkDomain = name: "${name}.${domain}";

  mkRewrites =
    lib.mapAttrsToList (name: port: {
      domain = mkDomain name;
      answer = enraiIP;
    })
    services;

  mkCaddyHosts =
    lib.mapAttrs' (
      name: port:
        lib.nameValuePair (mkDomain name) {
          useACMEHost = domain;
          extraConfig = ''
            bind ${enraiIP}
            reverse_proxy ${enraiIP}:${toString port}

            @blocked not remote_ip 10.0.0.0/24
            respond @blocked 403
          '';
        }
    )
    services;
in {
  # Keep systemd-resolved but configure it to use AdGuard
  services.resolved = {
    enable = true;
    dnssec = "false";
    fallbackDns = ["1.1.1.1" "8.8.8.8"];
    extraConfig = ''
      DNSStubListener=no
    '';
  };

  networking.nameservers = ["10.0.0.10"];

  services.adguardhome = {
    enable = true;
    openFirewall = false;
    mutableSettings = false;
    port = 9393;

    settings = {
      dns = {
        bind_hosts = ["10.0.0.10"];
        port = 53;
        bootstrap_dns = ["1.1.1.1"];
        upstream_dns = ["1.1.1.1"];
      };

      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
        rewrites = mkRewrites;
      };

      filters = [
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt";
          name = "AdGuard DNS filter";
          id = 1;
        }
      ];
    };
  };

  services.caddy.virtualHosts = mkCaddyHosts;
}
