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

    boot.loader = {
      systemd-boot.enable = false;

      grub = {
        enable = true;
        theme = "${pkgs.yorha-grub-theme}/yorha-1920x1080";
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    lib.mkDefault.console = {
      enable = true;
      font = "Lat2-Terminus16";
      useXkbConfig = true;
    };
  };
}
