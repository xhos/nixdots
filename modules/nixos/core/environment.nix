{pkgs, config, ...}: {
  environment = {
    shells = with pkgs; [nushell zsh fish];
    variables.FLAKE = "/etc/nixos";
  };
}
