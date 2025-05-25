{
  inputs,
  config,
  ...
}: let
  sopsFolder = builtins.toString inputs.nix-secrets;
  homeDirectory = config.home.homeDirectory;
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];
  sops = {
    age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = "${sopsFolder}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "ssh/kaminari/key" = {
        path = "${homeDirectory}/.ssh/kaminari.key";
        mode = "0600";
      };
    };
  };
}
