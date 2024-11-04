{
  programs = {
    fish.enable = true;
    zsh.enable = true;
    dconf.enable = true;
    ssh.startAgent = true;
  };
  environment.pathsToLink = ["/share/zsh"];
  # qt = {
  #   enable = true;
  #   platformTheme = "gtk2";
  #   style = "gtk2";
  # };
}
