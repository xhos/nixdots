{
  programs = {
    fish.enable = true;
    zsh.enable = true;
    dconf.enable = true;
    ssh.startAgent = true;
  };

  environment.pathsToLink = ["/share/zsh"];
}
