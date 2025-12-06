{inputs, ...}: {
  nixpkgs.overlays = [
    inputs.proxmox-nixos.overlays."x86_64-linux"
  ];

  networking = let
    amneziaIp = "10.0.0.21";
    mcIp = "10.0.0.20";
  in {
    firewall = {
      allowedTCPPorts = [8006];
      trustedInterfaces = ["vmbr0"];
    };

    nat = {
      enable = true;
      externalInterface = "wg0";
      internalInterfaces = ["vmbr0"];

      forwardPorts = [
        {
          sourcePort = 2222;
          destination = "${mcIp}:22";
          proto = "tcp";
        }
        {
          sourcePort = 25565;
          destination = "${mcIp}:25565";
          proto = "tcp";
        }

        {
          sourcePort = 2223;
          destination = "${amneziaIp}:22";
          proto = "tcp";
        }

        {
          sourcePort = 35000;
          destination = "${amneziaIp}:35000";
          proto = "tcp";
        }
        {
          sourcePort = 35001;
          destination = "${amneziaIp}:35001";
          proto = "tcp";
        }
        {
          sourcePort = 35002;
          destination = "${amneziaIp}:35002";
          proto = "tcp";
        }
        {
          sourcePort = 35003;
          destination = "${amneziaIp}:35003";
          proto = "tcp";
        }
        {
          sourcePort = 35004;
          destination = "${amneziaIp}:35004";
          proto = "tcp";
        }
        {
          sourcePort = 35005;
          destination = "${amneziaIp}:35005";
          proto = "tcp";
        }
        {
          sourcePort = 35006;
          destination = "${amneziaIp}:35006";
          proto = "tcp";
        }

        {
          sourcePort = 35000;
          destination = "${amneziaIp}:35000";
          proto = "udp";
        }
        {
          sourcePort = 35001;
          destination = "${amneziaIp}:35001";
          proto = "udp";
        }
        {
          sourcePort = 35002;
          destination = "${amneziaIp}:35002";
          proto = "udp";
        }
        {
          sourcePort = 35003;
          destination = "${amneziaIp}:35003";
          proto = "udp";
        }
        {
          sourcePort = 35004;
          destination = "${amneziaIp}:35004";
          proto = "udp";
        }
        {
          sourcePort = 35005;
          destination = "${amneziaIp}:35005";
          proto = "udp";
        }
        {
          sourcePort = 35006;
          destination = "${amneziaIp}:35006";
          proto = "udp";
        }
      ];
    };

    nftables.enable = true;
    nftables.tables.nat = {
      family = "ip";
      content = ''
        chain postrouting {
          type nat hook postrouting priority 100; policy accept;
          oifname "vmbr0" masquerade
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
