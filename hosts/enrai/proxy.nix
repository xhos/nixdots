{
  networking.firewall = {
    enable = true;
    trustedInterfaces = ["docker0" "wg0"];
    allowedTCPPorts = [443 80];
    allowedUDPPorts = [55055];
  };

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
}
