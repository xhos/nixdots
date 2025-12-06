{
  config,
  lib,
  ...
}: {
  sops.secrets."passwords/wakapi" = {};

  security.acme.certs."xhos.dev".extraDomainNames = ["wakapi.xhos.dev"];

  # unset dynamic user stuff which makes it difficult to persist
  systemd.services.wakapi.serviceConfig = {
    StateDirectory = lib.mkForce null;
    DynamicUser = lib.mkForce false;
    User = "wakapi";
    Group = "wakapi";
  };

  services.caddy.virtualHosts."wakapi.xhos.dev" = {
    useACMEHost = "xhos.dev";
    listenAddresses = ["10.100.0.10"];
    extraConfig = ''
      reverse_proxy 127.0.0.1:3333
    '';
  };

  services.wakapi = {
    enable = true;
    database.createLocally = true;

    passwordSaltFile = config.sops.secrets."passwords/wakapi".path;

    settings = {
      server.port = 3333;

      db = {
        dialect = "postgres";
        host = "127.0.0.1";
        name = "wakapi";
        user = "wakapi";
        port = 5432;
      };

      mail.enabled = false;

      security = {
        allow_signup = false;
        invite_codes = true;
        disable_frontpage = true;
      };
    };
  };
}
