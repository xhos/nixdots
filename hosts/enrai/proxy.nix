{pkgs, ...}: {
  services.nginx = {
    enable = true;
    virtualHosts."_" = {
      listen = [
        {
          addr = "10.0.0.2"; # Listen on WireGuard tunnel IP
          port = 80;
        }
      ];
      root = pkgs.writeTextDir "index.html" ''
        <!DOCTYPE html>
        <html>
        <head><title>Home Server</title></head>
        <body>
          <h1>Hello from Home Server!</h1>
          <p>This page is served through WireGuard tunnel.</p>
          <p>If you can see this, the proxy is working!</p>
        </body>
        </html>
      '';
    };
  };

  # WireGuard client configuration
  networking.wireguard.interfaces.wg0 = {
    ips = ["10.0.0.2/24"];
    privateKeyFile = "/etc/wireguard/private.key";

    peers = [
      {
        # VPS public key - replace with actual key after VPS setup
        publicKey = "YOUR_VPS_PUBLIC_KEY_HERE";

        # Route all traffic through VPS
        allowedIPs = ["0.0.0.0/0"];

        # VPS endpoint - replace with actual VPS IP
        endpoint = "YOUR_VPS_IP:51820";

        # Keep connection alive through NAT
        persistentKeepalive = 25;
      }
    ];
  };

  # Firewall configuration for WireGuard
  networking.firewall = {
    allowedUDPPorts = [51820]; # WireGuard port
    trustedInterfaces = ["wg0"]; # Trust tunnel traffic
  };

  # Auto-generate WireGuard keys on first boot
  system.activationScripts.wireguard-setup = ''
    mkdir -p /etc/wireguard
    chmod 700 /etc/wireguard

    if [ ! -f /etc/wireguard/private.key ]; then
      echo "Generating WireGuard private key..."
      ${pkgs.wireguard-tools}/bin/wg genkey > /etc/wireguard/private.key
      chmod 600 /etc/wireguard/private.key

      echo "=== WireGuard Public Key ==="
      ${pkgs.wireguard-tools}/bin/wg pubkey < /etc/wireguard/private.key
      echo "Add this key to your VPS configuration"
      echo "=========================="
    fi
  '';
}
