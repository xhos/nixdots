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
      "kaminari-2" = {
        host = "kaminari-2";
        hostname = "140.238.143.172";
        user = "ubuntu";
        identitiesOnly = true;
        identityFile = "~/.ssh/kaminari-2.key";
      };
      "new-arm" = {
        host = "new-arm";
        hostname = "140.238.145.169";
        user = "ubuntu";
        identitiesOnly = true;
        identityFile = "~/.ssh/new-arm.key";
      };
      "enrai" = {
        host = "enrai";
        hostname = "10.0.0.10";
        user = "xhos";
        port = 10022;
        identitiesOnly = true;
        identityFile = "~/.ssh/enrai";
      };
    };
  };
}
