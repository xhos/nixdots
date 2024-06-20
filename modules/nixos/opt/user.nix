{ pkgs, ... }: {
  users = {
    users.xhos = {
      isNormalUser = true;
      password = "123456";
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
