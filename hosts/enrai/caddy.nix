{config, ...}: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "lets-encrypt@xhos.dev";
    certs."xhos.dev" = {
      group = config.services.caddy.group;
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      extraDomainNames = ["wakapi.xhos.dev"];
      environmentFile = config.sops.secrets."api/cloudflare".path;
    };
  };

  services.caddy = {
    enable = true;
    email = "lets-encrypt@xhos.dev";
    globalConfig = "admin off";
  };

  sops.secrets."api/cloudflare" = {};
}
