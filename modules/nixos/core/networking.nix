let
  sshPort = 10022;
in {
  networking.wireless.iwd.enable = true;
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
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
