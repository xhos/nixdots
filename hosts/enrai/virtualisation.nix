{
  # docker
  virtualisation.docker.enable = true;

  # minecraft

  boot.kernel.sysctl = {
    "net.ipv4.conf.wg0.proxy_arp" = 1;
  };

  networking.firewall.allowedTCPPorts = [2222 1080 25565];

  # shared
  users.users.xhos.extraGroups = ["docker"];
}
