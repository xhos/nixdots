{
  # docker
  virtualisation.docker.enable = true;

  # minecraft

  boot.kernel.sysctl = {
    "net.ipv4.conf.wg0.proxy_arp" = 1;
  };

  # shared
  users.users.xhos.extraGroups = ["docker"];
}
