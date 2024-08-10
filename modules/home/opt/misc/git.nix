{
  programs.git = {
    enable = true;
    userName = "xhos";
    userEmail = "xxhos@pm.me";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };
}