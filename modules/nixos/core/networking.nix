{
  lib,
  config,
  ...
}: let
  sshPort = 10022;
in {
  services.resolved = {
    enable = true;
    fallbackDns = ["1.1.1.1" "9.9.9.9"];
    # Disables the systemd-resolved stub on 127.0.0.53
    # This is needed because browsers seem to prefer the stub over
    # /etc/resolv.conf, which would bypass our per-network DNS settings from NetworkManager.
    # Without this, a browser will always query 127.0.0.53 instead of using our
    # AdGuard DNS when connected to the home network.
    extraConfig = ''
      DNSStubListener=no
      DNS=10.0.0.10 9.9.9.9 1.1.1.1
    '';
  };

  services.fail2ban.enable = true;

  services.openssh = {
    enable = true;
    ports = [sshPort];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StreamLocalBindUnlink = "yes"; # automatically remove stale sockets
      GatewayPorts = "clientspecified"; # allow forwarding ports to everywhere
    };
  };

  networking = {
    networkmanager.enable = lib.mkIf (config.headless != true) true;

    firewall = {
      enable = true;
      allowedTCPPorts = [sshPort];
    };
  };
}
