{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  config = lib.mkIf (config.de == "plasma") {
    environment.systemPackages = [
      # sddm related
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qtvirtualkeyboard
      (pkgs.callPackage ../../../derivs/sddm-astronaut-theme.nix {
        theme = "japanese_aesthetic";
      })

      # cosmetic
      pkgs.kde-rounded-corners
      inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
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
