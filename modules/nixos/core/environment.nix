{pkgs, ...}: {
  environment = {
    shells = [pkgs.zsh];
    variables.NH_FLAKE = "/etc/nixos";
    variables.EDITOR = "nvim";
    variables.ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
