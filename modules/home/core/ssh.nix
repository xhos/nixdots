{
  config,
  lib,
  ...
}: {
  sops.secrets = lib.mkIf config.modules.secrets.enable {
    "ssh/proxy" = {
      path = "${config.home.homeDirectory}/.ssh/proxy.key";
      mode = "0600";
    };
    "ssh/arm" = {
      path = "${config.home.homeDirectory}/.ssh/arm.key";
      mode = "0600";
    };
    "ssh/enrai" = {
      path = "${config.home.homeDirectory}/.ssh/enrai.key";
      mode = "0600";
    };
    "ssh/vyverne" = {
      path = "${config.home.homeDirectory}/.ssh/vyverne.key";
      mode = "0600";
    };
    "ssh/zireael" = {
      path = "${config.home.homeDirectory}/.ssh/zireael.key";
      mode = "0600";
    };
  };

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
      "proxy-1" = {
        host = "proxy-1";
        hostname = "40.233.88.40";
        user = "root";
        identitiesOnly = true;
        identityFile = "~/.ssh/proxy.key";
      };
      "proxy-2" = {
        host = "proxy-2";
        hostname = "89.168.83.242";
        user = "root";
        identitiesOnly = true;
        identityFile = "~/.ssh/proxy.key";
      };
      "arm" = {
        host = "arm";
        hostname = "140.238.145.169";
        user = "ubuntu";
        identitiesOnly = true;
        identityFile = "~/.ssh/arm.key";
      };
      "enrai" = {
        host = "enrai";
        hostname = "10.0.0.10";
        user = "xhos";
        port = 10022;
        identitiesOnly = true;
        identityFile = "~/.ssh/enrai.key";
      };
      "vyverne" = {
        host = "vyverne";
        hostname = "10.0.0.11";
        user = "xhos";
        port = 10022;
        identitiesOnly = true;
        identityFile = "~/.ssh/vyverne.key";
      };
      "enrai-t" = {
        host = "enrai-t";
        hostname = "ssh.xhos.dev";
        user = "xhos";
        port = 10022;
        identitiesOnly = true;
        identityFile = "~/.ssh/enrai.key";
        proxyCommand = "cloudflared access ssh --hostname %h";
      };
    };
  };
}
