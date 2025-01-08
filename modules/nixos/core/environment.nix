{pkgs, ...}: {
  environment = {
    shells = with pkgs; [nushell zsh fish];
    variables.FLAKE = "/etc/nixos";
    variables.EDITOR = "nvim";
    variables.ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
