{pkgs, config, ...}: {
  environment = {
    shells = with pkgs; [nushell zsh];
    variables.FLAKE = "/etc/nixos";
  };
}
