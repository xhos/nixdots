{pkgs, ...}: {
  users = {
    users.xhos = {
      isNormalUser = true;
      initialPassword = "";
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
