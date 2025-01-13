{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  config = lib.mkIf (config.de == "plasma") {
    environment.systemPackages = [
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qtvirtualkeyboard

      inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
      (pkgs.callPackage ../../../derivs/sddm-astronaut-theme.nix {
        theme = "japanese_aesthetic";
      })
    ];

    services = {
      xserver.enable = false;
      desktopManager.plasma6.enable = true;

      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
      };
    };
  };
}
