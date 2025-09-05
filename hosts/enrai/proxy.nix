{pkgs, ...}: {
  networking.firewall = {
    enable = true;
    trustedInterfaces = ["docker0" "wg0"];
    allowedTCPPorts = [8081];
    allowedUDPPorts = [55055];
  };

  # virtualisation.docker.enable = true;
  #
  # users.users.xhos = {
  #   extraGroups = ["docker"];
  # };

  networking.wireguard.interfaces = {
    wg0 = {
      mtu = 1408;
      ips = ["10.100.0.2/24"];
      privateKeyFile = "/var/lib/wireguard/private.key";
      generatePrivateKeyFile = true;
      peers = [
        {
          publicKey = "2s3JqlwOOOjP+pNdTxObat6iBo11tFMFaB7uAKn6xXo=";
          endpoint = "192.18.152.177:55055";
          allowedIPs = ["10.100.0.1/32"];
          persistentKeepalive = 25;
        }
      ];
    };
  };

  services.caddy = {
    enable = true;
    globalConfig = ''
      auto_https off
      admin off
    '';
    # Bind only on the WG IP (10.100.0.2)
    virtualHosts."10.100.0.2:8081".extraConfig = ''
      respond "Hello World" 200
    '';
  };

  environment.systemPackages = with pkgs; [
    vim
    htop
    docker-compose
    wireguard-tools
    tcpdump
    netcat
    curl
  ];
}
