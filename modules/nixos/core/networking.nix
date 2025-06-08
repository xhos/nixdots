let
  sshPort = 10022;
in {
  services.resolved.enable = true;
  networking = {
    wireless = {
      enable = false; # make sure wpa_supplicant is disabled
      iwd.enable = true; # use iwd instead of wpa_supplicant
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [
        sshPort
        5900
      ];
    };
  };

  services.fail2ban.enable = true;

  # actully this needs to be enabled for sops to get the key
  # so, TODO: a better way to disable ssh
  services.openssh = {
    enable = true;
    ports = [sshPort];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StreamLocalBindUnlink = "yes"; # Automatically remove stale sockets
      GatewayPorts = "clientspecified"; # Allow forwarding ports to everywhere
    };
  };
}
