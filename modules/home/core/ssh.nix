{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github" = {
        host = "github.com";
        identitiesOnly = true;
        identityFile = "~/.ssh/github";
      };
    };
  };
}
