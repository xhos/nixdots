{
  systemd.services.qbittorrent.vpnConfinement = {
    enable = true;
    vpnNamespace = "proton";
  };

  services.qbittorrent = {
    enable = true;
    openFirewall = false;

    serverConfig = {
      LegalNotice.Accepted = true;

      BitTorrent.Session = {
        DefaultSavePath = "/storage/media/downloads";
      };

      Preferences.WebUI = {
        Address = "192.168.15.1";
        Username = "admin";
        Password_PBKDF2 = "@ByteArray(cWgbdiY0hx3ipPWL3nGZBg==:RlTSPXDqYIbTTw0Hr2EzSh56H/qY1nEk8FWtuA7lH+WCOAdHUOtZiLY4JyBYH7YU+c45RJFK+7wfMkT9J2XQYA==)";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /storage/media/downloads 0775 root media -"
  ];
}
