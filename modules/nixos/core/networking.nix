{ config, lib, ... }:
let
  sshPort = 10022;
in {
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        sshPort
      ] ;
    };
  };

  services.fail2ban.enable = true;

  # actully this needs to be enabled for sops to get the key
  # so, TODO: a better way to disable ssh
  services.openssh = {
    enable = true;
    ports = [ sshPort ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StreamLocalBindUnlink = "yes"; # Automatically remove stale sockets
      GatewayPorts = "clientspecified"; # Allow forwarding ports to everywhere
    };
  };
}