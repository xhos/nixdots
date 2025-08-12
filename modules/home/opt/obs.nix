{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.modules.obs.enable {
    home.packages = [pkgs.droidcam];

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [droidcam-obs];
    };
  };
}
