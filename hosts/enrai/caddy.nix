{config, ...}: {
  sops.secrets."api/cloudflare" = {};

  security.acme = {
    acceptTerms = true;
    defaults.email = "lets-encrypt@xhos.dev";
    certs."xhos.dev" = {
      group = config.services.caddy.group;
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      extraDomainNames = [
        "wakapi.xhos.dev"
        "adguard.xhos.dev"
        "bazarr.xhos.dev"
        "glance.xhos.dev"
        "ha.xhos.dev"
        "jellyfin.xhos.dev"
        "prowlarr.xhos.dev"
        "proxmox.xhos.dev"
        "qbit.xhos.dev"
        "sonarr.xhos.dev"
      ];
      environmentFile = config.sops.secrets."api/cloudflare".path;
    };
  };

  services.caddy = {
    enable = true;
    email = "lets-encrypt@xhos.dev";
    globalConfig = ''
      admin off
      servers {
        listener_wrappers {
          proxy_protocol {
            timeout 5s
            allow 10.100.0.0/24
          }
          tls
        }
      }
    '';
  };
}
