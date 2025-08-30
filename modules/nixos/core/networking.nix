{
  lib,
  config,
  ...
}: let
  sshPort = 10022;
in {
  services.resolved.enable = true;

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

    firewall = rec {
      enable = true;
      allowedTCPPorts = [sshPort];

      allowedTCPPortRanges = lib.optionals (config.headless != true) [
        {
          # KDE Connect ports
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };

  hardware.bluetooth.enable = lib.mkIf (config.headless != true && config.bluetooth.enable) true;
}
