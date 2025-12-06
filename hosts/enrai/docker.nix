{
  networking.firewall.trustedInterfaces = ["docker0"];
  virtualisation.docker.enable = true;
  users.users.xhos.extraGroups = ["docker"];
}
