{pkgs, ...}: {
  systemd.services.qbittorrent.vpnConfinement = {
    enable = true;
    vpnNamespace = "proton";
  };
  networking.firewall.allowedTCPPorts = [8080];
  services.qbittorrent = {
    enable = true;
    openFirewall = true;

    serverConfig = {
      LegalNotice.Accepted = true;

      BitTorrent.Session = {
        DefaultSavePath = "/storage/media/downloads";
      };

      Preferences.WebUI = {
        Address = "0.0.0.0";
        Username = "admin";
        Password_PBKDF2 = "@ByteArray(cWgbdiY0hx3ipPWL3nGZBg==:RlTSPXDqYIbTTw0Hr2EzSh56H/qY1nEk8FWtuA7lH+WCOAdHUOtZiLY4JyBYH7YU+c45RJFK+7wfMkT9J2XQYA==)";
      };
    };
  };

  systemd.services."qbittorrent-proxy" = {
    wantedBy = ["multi-user.target"];
    requires = ["qbittorrent.service"];
    after = ["qbittorrent.service"];
    serviceConfig = {
      ExecStart = "${pkgs.socat}/bin/socat TCP-LISTEN:8080,bind=10.0.0.10,fork,reuseaddr EXEC:'${pkgs.iproute2}/bin/ip netns exec proton ${pkgs.socat}/bin/socat STDIO TCP:192.168.15.1:8080',nofork";
      Restart = "always";
    };
  };

  systemd.tmpfiles.rules = [
    "d /storage/media/downloads 0775 root media -"
  ];
}
