{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.boot.enable {
    nixpkgs.overlays = [
      (final: prev: {
        yorha-grub-theme = import ../../../derivs/yorha-grub-theme.nix {
          inherit (final) fetchFromGitHub stdenvNoCC lib;
        };
      })
    ];

    boot = {
      plymouth.enable = true;
      loader = {
        systemd-boot.enable = false;
        efi.canTouchEfiVariables = true;
        grub = {
          enable = true;
          device = "nodev";
          backgroundColor = "#000";
          theme = pkgs.minimal-grub-theme;
          useOSProber = true;
          efiSupport = true;
        };
      };
    };
    # lib.mkDefault.console = {
    #   enable = true;
    #   font = "Lat2-Terminus16";
    #   useXkbConfig = true;
    # };
  };
}
