{
  # docker
  virtualisation.docker.enable = true;

  # minecraft
  virtualisation.incus.enable = true;
  networking.nftables.enable = true;

  boot.kernel.sysctl = {
    "net.ipv4.conf.wg0.proxy_arp" = 1;
  };

  networking.firewall.allowedTCPPorts = [2222 25565];

  # shared
  users.users.xhos.extraGroups = ["incus-admin" "docker"];
}
