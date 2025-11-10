{
  config,
  inputs,
  ...
}: {
  nixpkgs.overlays = [
    inputs.proxmox-nixos.overlays.${config.nixpkgs.hostPlatform.system}
  ];

  networking = {
    firewall = {
      allowedTCPPorts = [8006];
      trustedInterfaces = ["vmbr0"];
    };

    nftables.enable = true;
    nftables.tables.nat = {
      family = "ip";
      content = ''
        chain prerouting {
          type nat hook prerouting priority -100; policy accept;
          iifname "wg0" tcp dport 2222 dnat to 10.0.0.30:22
          iifname "wg0" tcp dport 25565 dnat to 10.0.0.30:25565
        }
        chain postrouting {
          type nat hook postrouting priority 100; policy accept;
          oifname "vmbr0" ip daddr 10.0.0.30 tcp dport 22 masquerade
          oifname "vmbr0" ip daddr 10.0.0.30 tcp dport 25565 masquerade
        }
      '';
    };

    bridges.vmbr0.interfaces = ["enp0s31f6"];

    interfaces.enp0s31f6.useDHCP = false;

    interfaces.vmbr0 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "10.0.0.10";
          prefixLength = 24;
        }
      ];

      ipv6.addresses = [
        {
          address = "2607:fea8:fc01:741e::10";
          prefixLength = 64;
        }
      ];
    };

    defaultGateway = "10.0.0.1";
    nameservers = ["1.1.1.1" "8.8.8.8"];
  };

  services.proxmox-ve = {
    enable = true;
    ipAddress = "10.0.0.10";
    bridges = ["vmbr0"];
  };
}
