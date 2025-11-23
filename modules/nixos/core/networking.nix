{
  lib,
  config,
  ...
}: let
  sshPort = 10022;
in {
  services.resolved = {
    enable = true;
    fallbackDns = [ "1.1.1.1" "9.9.9.9" ]; # used only if all NetworkManager provided nameservers fail
    
    # Disables the systemd-resolved stub on 127.0.0.53
    # This is needed because browsers seem to prefer the stub over
    # /etc/resolv.conf, which would bypass our per-network DNS settings from NetworkManager.
    # Without this, a browser will always query 127.0.0.53 instead of using our
    # AdGuard DNS when connected to the home network.
    extraConfig = "DNSStubListener=no"; 
  };

  # 10.0.0.10 is the AdGuard DNS server on the home network
  networking.nameservers = [ "10.0.0.10" "9.9.9.9" "1.1.1.1" ];
  # Force systemd-resolved to restart (not just reload) when config changes
  # This ensures DNSStubListener=no is actually applied during nixos-rebuild
  systemd.services.systemd-resolved = {
    restartTriggers = [ 
      config.services.resolved.extraConfig 
    ];
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

  hardware.bluetooth.enable = lib.mkIf config.bluetooth.enable true;
}
