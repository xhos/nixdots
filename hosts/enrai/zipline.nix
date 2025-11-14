{config, ...}: {
  sops.secrets."env/zipline" = {};

  security.acme.certs."xhos.dev".extraDomainNames = ["pics.xhos.dev"];

  services.caddy.virtualHosts."pics.xhos.dev" = {
    useACMEHost = "xhos.dev";
    listenAddresses = ["10.100.0.2"];
    extraConfig = "reverse_proxy 127.0.0.1:3334";
  };

  services.zipline = {
    enable = true;
    environmentFiles = [config.sops.secrets."env/zipline".path];

    settings = {
      CORE_HOSTNAME = "127.0.0.1";
      CORE_PORT = 3334;
      EXIF_REMOVE_GPS = "true";
      FEATURES_ROBOTS_TXT = "true";
      MFA_TOTP_ISSUER = "xhos's zipline";
      MFA_TOTP_ENABLED = "true";
      RATELIMIT_ADMIN = "0";
      UPLOADER_DEFAULT_FORMAT = "RANDOM";
      UPLOADER_ROUTE = "/u";
      UPLOADER_LENGTH = "8";
      UPLOADER_ASSUME_MIMETYPES = "true";
      URLS_ROUTE = "/s";
      WEBSITE_TITLE = "xhos's zipline";
      WEBSITE_SHOW_FILES_PER_USER = "true";
      WEBSITE_SHOW_VERSION = "true";
    };
  };
}
