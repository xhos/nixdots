{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = ./secrets.yaml;
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
      # "api_keys/openai"    = {path = "/home/xhos/.secrets/openai";};
      # "api_keys/gemeni"    = {path = "/home/xhos/.secrets/gemeni";};
      # "api_keys/anthropic" = {path = "/home/xhos/.secrets/anthropic";};
      "api_keys/openai" = {};
      "api_keys/gemeni" = {};
      "api_keys/anthropic" = {};
      # "ssh/github" = {path = "/home/xhos/.ssh/github";};

      # "ssh/github".neededForUsers = true;
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
