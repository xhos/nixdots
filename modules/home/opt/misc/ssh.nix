{ config, ... }: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host manager
        HostName ${config.sops.secrets.ssh.manager_ip.path}
        User ${config.sops.secrets.ssh.manager_user.path}
        Port 22

      Host arm
        HostName ${config.sops.secrets.ssh.arm_ip.path}
        User ${config.sops.secrets.ssh.arm_user.path}
        Port 22

      Host web
        HostName ${config.sops.secrets.ssh.web_ip.path}
        User ${config.sops.secrets.ssh.web_user.path}
        Port 22
    '';
  };
}