{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
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
      "proxy" = {
        host = "proxy";
        hostname = "192.18.152.177";
        user = "root";
        identitiesOnly = true;
        identityFile = "~/.ssh/proxy.key";
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
      "enrai-t" = {
        host = "enrai-t";
        hostname = "ssh.xhos.dev";
        user = "xhos";
        port = 10022;
        identitiesOnly = true;
        identityFile = "~/.ssh/enrai";
        proxyCommand = "cloudflared access ssh --hostname %h";
      };
    };
  };
}
