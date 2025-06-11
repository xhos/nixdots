{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github" = {
        host = "github.com";
        identitiesOnly = true;
        identityFile = "~/.ssh/github-auth-key";
      };
      "azure" = {
        host = "ssh.dev.azure.com";
        identityFile = "~/.ssh/azure";
        identitiesOnly = true;
      };
      "kaminari" = {
        host = "kaminari";
        hostname = "40.233.72.203";
        user = "ubuntu";

        identitiesOnly = true;
        identityFile = "~/.ssh/kaminari.key";
      };
    };
  };
}
