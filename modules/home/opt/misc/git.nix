{
  programs.git = {
    enable = true;
    userName = "xhos";
    userEmail = "mark@xhos.dev";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };
}