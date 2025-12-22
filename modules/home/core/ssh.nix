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
    "ssh/monitor" = {
      path = "${config.home.homeDirectory}/.ssh/monitor.key";
      mode = "0600";
    };
    "ssh/vault" = {
      path = "${config.home.homeDirectory}/.ssh/vault.key";
      mode = "0600";
    };
    "ssh/mc" = {
      path = "${config.home.homeDirectory}/.ssh/mc.key";
      mode = "0600";
    };
    "ssh/vyverne" = {
      path = "${config.home.homeDirectory}/.ssh/vyverne.key";
      mode = "0600";
    };
    "ssh/enrai" = {
      path = "${config.home.homeDirectory}/.ssh/enrai.key";
      mode = "0600";
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      # git
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
      # VPS
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
      "monitor" = {
        host = "monitor";
        hostname = "40.233.127.68";
        user = "root";
        identitiesOnly = true;
        identityFile = "~/.ssh/monitor.key";
      };
      "vault" = {
        host = "vault";
        hostname = "40.233.74.249";
        user = "ubuntu";
        identitiesOnly = true;
        identityFile = "~/.ssh/vault.key";
      };
      # VM
      "mc" = {
        host = "mc";
        hostname = "xhos.dev";
        port = 2222;
        user = "mc";
        identitiesOnly = true;
        identityFile = "~/.ssh/mc.key";
      };
      # bare metal
      "vyverne" = {
        host = "vyverne";
        hostname = "10.0.0.11";
        user = "xhos";
        port = 10022;
        identitiesOnly = true;
        identityFile = "~/.ssh/vyverne.key";
      };
      "enrai" = {
        host = "enrai";
        hostname = "10.0.0.10";
        user = "xhos";
        port = 10022;
        identitiesOnly = true;
        identityFile = "~/.ssh/enrai.key";
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
