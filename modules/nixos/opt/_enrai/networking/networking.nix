{
  lib,
  config,
  ...
}: let
  vmNetwork = "192.168.100";
  mcIp = "${vmNetwork}.20";
  amneziaIp = "${vmNetwork}.21";

  # Core infrastructure ports
  coreServicePorts = {
    ssh = 10022;
    proxmox = 8006;
    adguard-dns = 53;
    adguard-web = 9393;
    http = 80;
    https = 443;
    wireguard = 55055;
    dhcp-server = 67;
    dhcp-client = 68;
    syncthing-sync = 22000;
  };

  # Collect dynamically registered services
  exposedServices = lib.attrValues config._enrai.exposedServices;
  dynamicServicePorts = lib.unique (map (s: s.port) exposedServices);

  # Combine core and dynamic ports for LAN-exposed services
  lanTcpPorts =
    [
      coreServicePorts.proxmox
      coreServicePorts.adguard-web
      coreServicePorts.http
      coreServicePorts.https
    ]
    ++ dynamicServicePorts;

  # Helper to generate nftables set syntax: { port1, port2, port3 }
  mkPortSet = ports: "{ ${lib.concatMapStringsSep ", " toString ports} }";
in {
  # Option for services to self-register for network exposure
  options._enrai.exposedServices = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        port = lib.mkOption {
          type = lib.types.port;
          description = "Port the service listens on";
        };
        exposed = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to expose via WireGuard tunnel to internet";
        };
        # Optional overrides (defaults to attribute name)
        name = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Human-readable service name (defaults to attribute name)";
        };
        subdomain = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Subdomain for the service (defaults to attribute name)";
        };
      };
    });
    default = {};
    description = "Services that should be exposed on the local network";
  };

  config = {
    networking.firewall.enable = lib.mkForce false;

    networking.nftables = {
      enable = true;

      ruleset = ''
        table inet filter {
          # ============================================
          # INPUT CHAIN - Traffic destined for enrai
          # ============================================
          chain input {
            type filter hook input priority filter; policy drop;

            # Allow established/related connections (responses to outgoing traffic)
            ct state vmap { established : accept, related : accept, invalid : drop }

            # Allow all loopback traffic (local services talking to each other)
            iifname lo accept

            # Allow ICMP (ping, traceroute, etc)
            ip protocol icmp accept
            ip6 nexthdr icmpv6 accept

            # Core services accessible from anywhere
            tcp dport ${toString coreServicePorts.ssh} accept
            udp dport ${toString coreServicePorts.wireguard} accept

            # Services exposed to main LAN only (10.0.0.0/24) - combined into single rule
            iifname vmbr0 ip saddr 10.0.0.0/24 tcp dport ${mkPortSet lanTcpPorts} accept

            # AdGuard DNS (both TCP and UDP)
            iifname vmbr0 ip saddr 10.0.0.0/24 udp dport ${toString coreServicePorts.adguard-dns} accept
            iifname vmbr0 ip saddr 10.0.0.0/24 tcp dport ${toString coreServicePorts.adguard-dns} accept

            # Syncthing sync (TCP + UDP)
            iifname vmbr0 ip saddr 10.0.0.0/24 tcp dport ${toString coreServicePorts.syncthing-sync} accept
            iifname vmbr0 ip saddr 10.0.0.0/24 udp dport ${toString coreServicePorts.syncthing-sync} accept

            # DHCP server for VMs
            iifname vmbr0 udp dport ${toString coreServicePorts.dhcp-server} accept
            iifname vmbr0 udp sport ${toString coreServicePorts.dhcp-client} accept

            # Allow all traffic from WireGuard tunnel (VPS proxies)
            iifname wg0 accept

            # CRITICAL: Block VMs from accessing host services
            # Must be last - drops any VM traffic not explicitly allowed above
            iifname vmbr0 ip saddr 192.168.100.0/24 drop
          }

          # ============================================
          # FORWARD CHAIN - Traffic being routed through enrai
          # ============================================
          chain forward {
            type filter hook forward priority filter; policy drop;

            # Allow established/related connections (return traffic)
            ct state vmap { established : accept, related : accept, invalid : drop }

            # CRITICAL: Block VMs from reaching host (10.0.0.0/24) or each other (192.168.100.0/24)
            # Must match by destination IP, not interface, because bridge makes both in/out = vmbr0
            ip saddr 192.168.100.0/24 ip daddr { 10.0.0.0/24, 192.168.100.0/24 } drop

            # Allow VMs to reach the internet (everything not blocked above)
            ip saddr 192.168.100.0/24 accept

            # Allow main LAN and WireGuard tunnel to reach VMs (for management + port forwards)
            ip daddr 192.168.100.0/24 accept
          }

          # ============================================
          # OUTPUT CHAIN - Traffic originating from enrai
          # ============================================
          chain output {
            type filter hook output priority filter; policy accept;
          }
        }

        # ============================================
        # NAT TABLE - Network Address Translation
        # ============================================
        table ip nat {
          # DNAT - Rewrite destination (port forwarding)
          chain prerouting {
            type nat hook prerouting priority dstnat; policy accept;

            # Port forwards from WireGuard tunnel to VMs
            iifname wg0 tcp dport 2222 dnat to ${mcIp}:22              # Minecraft SSH
            iifname wg0 tcp dport 2223 dnat to ${amneziaIp}:22         # Amnezia SSH
            iifname wg0 tcp dport 25565 dnat to ${mcIp}:25565          # Minecraft game
            iifname wg0 tcp dport 35000-35006 dnat to ${amneziaIp}     # Amnezia VPN (TCP)
            iifname wg0 udp dport 35000-35006 dnat to ${amneziaIp}     # Amnezia VPN (UDP)
          }

          # SNAT - Rewrite source (masquerade for outgoing traffic)
          chain postrouting {
            type nat hook postrouting priority srcnat; policy accept;

            # Masquerade VM traffic going to internet
            # Makes packets appear to come from enrai's IP instead of VM IPs
            ip saddr 192.168.100.0/24 masquerade
          }
        }
      '';
    };

    # DNS configuration for enrai itself
    services.resolved.extraConfig = lib.mkForce ''
      DNSStubListener=no
    '';

    # Use local AdGuard first, fallback to public DNS if it fails
    networking.nameservers = lib.mkForce ["127.0.0.1" "1.1.1.1"];
  };
}
