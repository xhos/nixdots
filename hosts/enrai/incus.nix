{
  virtualisation.incus.enable = true;
  networking.nftables.enable = true;
  users.users.xhos.extraGroups = ["incus-admin"];

  boot.kernel.sysctl = {
    "net.ipv4.conf.wg0.proxy_arp" = 1;
  };

  # minecraft ports
  networking.firewall.allowedTCPPorts = [2222 25565];
}
