{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.obs.enable {
    programs.droidcam.enable = true;

    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      # doesn't compile :(
      # plugins = with pkgs.obs-studio-plugins; [
      #   droidcam-obs
      # ];
    };
  };
}
