{pkgs, ...}: {
  environment = {
    shells = [pkgs.zsh];
    variables.FLAKE = "/etc/nixos";
    variables.EDITOR = "zeditor";
    variables.ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
