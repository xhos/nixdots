{config, ...}: {
  sops.secrets."passwords/microsocks" = {
    owner = config.services.microsocks.user;
    mode = "0400";
  };

  systemd.services.microsocks.vpnConfinement = {
    enable = true;
    vpnNamespace = "proton";
  };

  services.microsocks = {
    enable = true;
    ip = "192.168.15.1";
    port = 1080;
    authUsername = "admin";
    authPasswordFile = config.sops.secrets."passwords/microsocks".path;
    authOnce = true;
  };
}
