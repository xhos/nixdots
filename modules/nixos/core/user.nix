{pkgs, ...}: {
  users = {
    users.xhos = {
      isNormalUser = true;
      # hashedPasswordFile = config.sops.secrets.password.path;
      extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "video"
        "libvirtd"
        "docker"
      ];
    };
    defaultUserShell = pkgs.zsh;
  };
}
