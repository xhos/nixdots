{ pkgs, config, ... }: {
  environment = {
    shells = with pkgs; [nushell zsh fish];
    variables.FLAKE = "/etc/nixos"; # path to this config
    variables.EDITOR = "nvim";
    variables.ELECTRON_OZONE_PLATFORM_HINT="auto";
  };
}
