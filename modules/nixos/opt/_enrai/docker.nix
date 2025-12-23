{
  networking.firewall.trustedInterfaces = ["docker0"];
  virtualisation.docker = {
    enable = true;
    daemon.settings.ip-forward = false;
  };
  users.users.xhos.extraGroups = ["docker"];
}
