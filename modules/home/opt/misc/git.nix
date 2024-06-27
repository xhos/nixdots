{
  programs.git ={
    enable = true;
    programs.git.userName = "xhos";
    userEmail = "xxhos@pm.me";
    programs.git.extraConfig.init.defaultBranch = "main";
  };
}