{
  pkgs,
  inputs,
  config,
  ...
}: let
secretspath = builtins.toString inputs.nix-secrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    age = {
      # import host ssh key as age key
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      # this will use an age key that is expected to be already in the filesystem
      keyFile = "/var/lib/sops-nix/key.txt";
      # genrete new key if above does not exist
      generateKey = true;
    };

    secrets = {
      "api_keys/openai" = {};
      "api_keys/gemeni" = {};
      "api_keys/anthropic" = {};
      # "gh_ssh" = { path = "/home/xhos/.ssh/github"; };

      # "gh_ssh".neededForUsers = true;
      # password.neededForUsers = true; # needed for the password to be accessible before login

      # all secrets need to be defined here to be accessible
      # also for some reason ints are not allowed and need to be quoted
      # for example "22" instead of 22
      # "ssh/personal_key" = { path = "/home/xhos/.ssh/personal_key"; };

      # "ssh/manager/ip" = { };
      # "ssh/manager/port" = { };
      # "ssh/manager/username" = { };

      # "ssh/web/ip" = { };
      # "ssh/web/port" = { };
      # "ssh/web/username" = { };

      # "ssh/arm/ip" = { };
      # "ssh/arm/port" = { };
      # "ssh/arm/username" = { };
    };
  };
}
