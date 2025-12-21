# ❄️ nixdots

<details>
<summary>old screenshots</summary>

## old setup using [aard](https://github.com/xhos/aard)

<p float="left">
  <img src="./ss1.png" width="400" />
  <img src="./ss2.png" width="400" /> 
  <img src="./ss3.png" width="400" />
  <img src="./ss4.png" width="400" />
</p>

</details>

all wallpapers can can be found [here](https://pics.xhos.dev/folder/cmgs64vh4000amzfs6t7oqy3f)

## 🌌 main features

- modular setup, everything is toggleable and switchable
- easy full system theming with stylix, based on the wallpaper or a base16 scheme
- secret management with sops-nix
- touch support with hyprgrass
- integrated onedrive & protondrive mounts 
- preconfigured web apps
- fully-themed login screens with sddm and grub

## 🏠 homelab

[enrai](../hosts/enrai) is my headless optiplex 5050 running a bunch of cool things, ~99% declarative. zsh, impermanence, secrets, all that good stuff:

- networking: caddy reverse proxy with cloudflare acme + nat port forwarding over wirguard to the vps running my [nix-wg-proxy](https://github.com/xhos/nix-wg-proxy)
- media pipeline: jellyfin + the usual *arr stack + qbittorrent with proton vpn
- home assistant: yandex station max controlling wled and [wled-album-sync](https://github.com/xhos/wled-album-sync)
- proxmox-nix running 2 vms, one for game servers, other for amnezia vpn (the only not fully declarative part)
- zipline, wakapi, synthing, glance and more

## 📦 repo structure

- **[derivs](../derivs):** nixpkgs overlays/derivations
- **[home](../home):** per host home-manager entrypoints
- **[hosts](../hosts):** host-specific configurations
- **[modules](../modules):**
  - **[home](../modules/home):** home-manager related modules
    - **[core](../modules/home/core):** core modules
    - **[opt](../modules/home/opt):** optional and toggleable modules
  - **[nixos](../modules/nixos):** nixos related modules
    - **[core](../modules/nixos/core):** core modules
    - **[opt](../modules/nixos/opt):** optional and toggleable modules

## ℹ️ info

| component          | details                                                 |
| ------------------ | ------------------------------------------------------- |
| de/wm              | [hyprland](https://hypr.land/)                          |
| greeter            | [yawn](https://github.com/xhos/yawn) (i made this!)     |
| terminal           | [foot](https://codeberg.org/dnkl/foot)                  |
| shell              | [zsh](https://www.zsh.org/)                             |
| bar                | [waybar](https://github.com/Alexays/Waybar)             |
| browser            | [zen](https://zen-browser.app)                          |
| runner             | [rofi](https://github.com/davatorium/rofi)              |
| prompt             | [starship](https://starship.rs/)                        |
| file manager       | [nautilus](https://apps.gnome.org/Nautilus/)            |
| notification       | [mako](https://github.com/emersion/mako)                |
| clipboard manager  | [clipse](https://github.com/savedra1/clipse)            |
| fetch              | [fastfetch](https://github.com/fastfetch-cli/fastfetch) |

## 🔒️ hyprlock

| name | preview | sources |
| :--- | :--- | :--- |
| **Main (Animated)** | <img src="./hyprlock.gif" alt="main Hyprlock Style" width="400" /> | [config](https://github.com/xhos/nixdots/tree/9692b91df9fa7896a59af807010780d1c9bffad7/modules/home/opt/hypr/hyprlock/hyprlock.conf) <br> [assets](https://github.com/xhos/nixdots/tree/9692b91df9fa7896a59af807010780d1c9bffad7/modules/home/opt/hypr/hyprlock/assets/) <br> [scripts](https://github.com/xhos/nixdots/tree/9692b91df9fa7896a59af807010780d1c9bffad7/modules/home/opt/hypr/hyprlock/scripts/) <br> [fonts](../modules/home/core/fonts/font-files/) |
| **Alternative (Static)** | <img src="./hyprlock-alt.png" alt="alternative Hyprlock Style" width="400" /> | [config](https://github.com/xhos/nixdots/tree/9692b91df9fa7896a59af807010780d1c9bffad7/modules/home/opt/hypr/hyprlock/hyprlock-alt.conf) <br> [assets](https://github.com/xhos/nixdots/tree/9692b91df9fa7896a59af807010780d1c9bffad7/modules/home/opt/hypr/hyprlock/assets/) <br> [scripts](https://github.com/xhos/nixdots/tree/9692b91df9fa7896a59af807010780d1c9bffad7/modules/home/opt/hypr/hyprlock/scripts/) <br> [fonts](../modules/home/core/fonts/font-files/) |

fonts used are:

- Maratype (credit to @notevencontestplayer on discord)
- KH Interference
- Synchro
- Nimbus Sans L Thin
- Nimbus Sans Black

## 🖌️ themed apps

> [!note]
> most of these automatically follow the stylix color scheme

- discord:  [system24](https://github.com/refact0r/system24)
- firefox:  [scifox](https://github.com/scientiac/scifox)
- obsidian: [anuppuccin](https://github.com/AnubisNekhet/AnuPpuccin)
- spotify:  [text](https://github.com/spicetify/spicetify-themes/tree/master/text)
- and more that i'm forgetting...

## 💡 acknowledgments

- [@joshuagrisham](https://github.com/joshuagrisham) for his work on [the galaxy book driver](https://github.com/joshuagrisham/samsung-galaxybook-extras)
- [@itzderock](https://github.com/ItzDerock) for sharing his [nix derivation](https://github.com/joshuagrisham/samsung-galaxybook-extras/issues/14#issue-2328871732) for that driver (now irrelevant since it was merged upstream)
- [@elyth](https://github.com/elythh), my config started as a fork of his [flake](https://github.com/elythh/flake)
- [hyprstellar](https://github.com/xeji01/hyprstellar/tree/main) for icons and general style inspiration

temp for my own reference, pretend its not here, github just renders it nicely:
```mermaid
graph TB
    subgraph Internet["🌍 Internet"]
        Client["External Clients"]
        VPS1["VPS proxy-1<br/>40.233.88.40"]
        VPS2["VPS proxy-2<br/>89.168.83.242"]
        PublicDNS["Public DNS<br/>1.1.1.1 / 8.8.8.8"]
    end

    subgraph "Main LAN (10.0.0.0/24) - Trusted Zone"
        Router["Router<br/>10.0.0.1<br/>DHCP + Gateway"]
        Vyverne["vyverne<br/>10.0.0.11<br/>Work/Gaming PC"]
        IoT["IoT Devices<br/>WLED (10.0.0.31)<br/>Yandex Station (10.0.0.30)"]
    end

    subgraph Enrai["enrai - Main Homelab (Optiplex 5050)"]
        subgraph Interfaces["Network Interfaces"]
            vmbr0Main["vmbr0: 10.0.0.10<br/>(Main LAN)"]
            vmbr0VM["vmbr0: 192.168.100.1<br/>(VM Gateway)"]
            wg0["wg0: 10.100.0.10<br/>(WireGuard Tunnel)"]
        end

        subgraph Infrastructure["Infrastructure Services"]
            SSH["SSH<br/>:10022"]
            AdGuard["AdGuard Home<br/>DNS :53<br/>Web :9393"]
            Proxmox["Proxmox VE<br/>:8006"]
            Caddy["Caddy Reverse Proxy<br/>HTTP :80<br/>HTTPS :443"]
            dnsmasq["dnsmasq<br/>VM DHCP :67"]
        end

        subgraph LocalServices["Local Services (*.lab.xhos.dev)<br/>LAN-Only Access via Caddy"]
            Glance["Glance<br/>:3000"]
            Syncthing["Syncthing<br/>Web :8384<br/>Sync :22000"]
            Jellyfin["Jellyfin<br/>:8096"]
            Sonarr["Sonarr<br/>:8989"]
            Bazarr["Bazarr<br/>:6767"]
            Prowlarr["Prowlarr<br/>:9696"]
            qBit["qBittorrent<br/>:8080"]
            HA["Home Assistant<br/>:8123"]
        end

        subgraph PublicServices["Public Services (*.xhos.dev)<br/>Internet-Exposed via WireGuard"]
            Wakapi["Wakapi<br/>:3333<br/>wakapi.xhos.dev"]
        end

        subgraph Firewall["nftables Firewall"]
            InputRules["INPUT Chain<br/>✅ SSH, WireGuard<br/>✅ LAN → All Services<br/>✅ wg0 → All<br/>🔴 VMs → BLOCKED"]
            ForwardRules["FORWARD Chain<br/>🔴 VMs → LAN: DROP<br/>🔴 VMs → VMs: DROP<br/>✅ VMs → Internet: ACCEPT<br/>✅ LAN/WG → VMs: ACCEPT"]
            NATRules["NAT Rules<br/>DNAT: WG ports → VMs<br/>SNAT: VM traffic masquerade"]
        end
    end

    subgraph VMSubnet["VM Subnet (192.168.100.0/24)<br/>🔒 ISOLATED - Internet Only"]
        MC["Minecraft VM<br/>192.168.100.20<br/>BC:24:11:18:FA:6B"]
        Amnezia["Amnezia VPN VM<br/>192.168.100.21<br/>BC:24:11:1F:12:A5<br/>🚨 UNTRUSTED"]
        
        VMRules["Security Policy:<br/>🔴 NO access to 10.0.0.0/24<br/>🔴 NO VM-to-VM communication<br/>✅ Internet access only<br/>DNS: 1.1.1.1, 8.8.8.8"]
    end

    subgraph WGTunnel["WireGuard Tunnel (10.100.0.0/24)"]
        Tunnel["Encrypted Tunnel<br/>MTU: 1408<br/>Keepalive: 25s"]
        PortFwds["Port Forwards:<br/>:2222 → MC SSH<br/>:2223 → Amnezia SSH<br/>:25565 → Minecraft<br/>:35000-35006 → Amnezia VPN"]
    end

    subgraph ACMECerts["TLS Certificates"]
        LabCert["*.lab.xhos.dev<br/>Wildcard Cert<br/>DNS-01 Challenge"]
        PubCert["*.xhos.dev<br/>Wildcard Cert<br/>DNS-01 Challenge"]
    end

    %% Internet connections
    Client -->|"HTTPS :443"| VPS1
    Client -->|"HTTPS :443"| VPS2
    VPS1 <-->|"WireGuard :55055<br/>PROXY Protocol"| wg0
    VPS2 <-->|"WireGuard :55055<br/>PROXY Protocol"| wg0

    %% Main LAN connections
    Router -->|"DHCP<br/>DNS: 10.0.0.10"| Vyverne
    Router -->|"DHCP<br/>DNS: 10.0.0.10"| IoT
    Router --- vmbr0Main

    %% DNS flows (proper)
    Vyverne -->|"1. Query *.lab.xhos.dev"| AdGuard
    AdGuard -->|"2. Upstream for other domains"| PublicDNS
    AdGuard -->|"3. Rewrite *.lab.xhos.dev → 10.0.0.10"| Caddy
    MC -->|"DNS queries bypass enrai"| PublicDNS
    Amnezia -->|"DNS queries bypass enrai"| PublicDNS

    %% Service access
    Vyverne -->|"HTTPS"| Caddy
    Caddy -->|"Reverse Proxy"| LocalServices
    Caddy -->|"Reverse Proxy<br/>PROXY Protocol"| PublicServices

    %% VM connections
    vmbr0VM -->|"DHCP<br/>DNS: 1.1.1.1, 8.8.8.8<br/>Gateway: 192.168.100.1"| dnsmasq
    dnsmasq -.-> MC
    dnsmasq -.-> Amnezia
    
    %% VM isolation
    MC -.->|"✅ NAT Masquerade"| Internet
    Amnezia -.->|"✅ NAT Masquerade"| Internet
    MC -.->|"🔴 BLOCKED"| vmbr0Main
    Amnezia -.->|"🔴 BLOCKED"| vmbr0Main
    MC -.->|"🔴 BLOCKED"| Amnezia

    %% WireGuard to VMs
    wg0 -->|"Port Forwards"| PortFwds
    PortFwds -.-> MC
    PortFwds -.-> Amnezia

    %% Firewall enforcement
    Firewall -.->|"Enforces"| InputRules
    Firewall -.->|"Enforces"| ForwardRules
    Firewall -.->|"Enforces"| NATRules

    %% ACME
    LabCert -.->|"Used by"| Caddy
    PubCert -.->|"Used by"| Caddy

    %% Styling
    classDef internet fill:#ff6b6b,stroke:#c92a2a,color:#fff,stroke-width:3px
    classDef trusted fill:#51cf66,stroke:#2f9e44,color:#000,stroke-width:2px
    classDef isolated fill:#ffd43b,stroke:#fab005,color:#000,stroke-width:3px
    classDef untrusted fill:#ff8787,stroke:#fa5252,color:#000,stroke-width:3px
    classDef service fill:#74c0fc,stroke:#1c7ed6,color:#000,stroke-width:2px
    classDef publicservice fill:#a78bfa,stroke:#7c3aed,color:#fff,stroke-width:2px
    classDef security fill:#ff6b9d,stroke:#c2255c,color:#fff,stroke-width:3px
    classDef infra fill:#ffd8a8,stroke:#fd7e14,color:#000,stroke-width:2px

    class Client,VPS1,VPS2,Internet,PublicDNS internet
    class Router,Vyverne,IoT trusted
    class MC isolated
    class Amnezia,VMRules untrusted
    class LocalServices,Glance,Syncthing,Jellyfin,Sonarr,Bazarr,Prowlarr,qBit,HA service
    class PublicServices,Wakapi publicservice
    class Firewall,InputRules,ForwardRules,NATRules security
    class Infrastructure,SSH,AdGuard,Proxmox,Caddy,dnsmasq infra
```
