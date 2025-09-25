{
  inputs,
  config,
  lib,
  ...
}: let
  sopsFolder = builtins.toString inputs.nix-secrets;
  homeDirectory = config.home.homeDirectory;
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  config = lib.mkIf config.modules.secrets.enable {
    sops = {
      age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";

      defaultSopsFile = "${sopsFolder}/secrets.yaml";
      validateSopsFiles = false;

      secrets = {
        "ssh/proxy" = {
          path = "${homeDirectory}/.ssh/proxy.key";
          mode = "0600";
        };
        "ssh/arm" = {
          path = "${homeDirectory}/.ssh/arm.key";
          mode = "0600";
        };
        "ssh/enrai" = {
          path = "${homeDirectory}/.ssh/enrai.key";
          mode = "0600";
        };
        "ssh/vyverne" = {
          path = "${homeDirectory}/.ssh/vyverne.key";
          mode = "0600";
        };
        "ssh/zireael" = {
          path = "${homeDirectory}/.ssh/zireael.key";
          mode = "0600";
        };
      };
    };
  };
}
