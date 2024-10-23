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
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      # "ssh/github" = { };
      "ssh/github" = {path = "/home/xhos/.ssh/github";};

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
