{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [inputs.aard.homeManagerModules.aard];

  config = lib.mkIf (config.default.bar == "aard") {
    programs.aard = {
      enable = true;
      wallpaper = config.stylix.image;
      transparency = true;
      hyprsplit = true;
      systemd.enable = true;
    };
  };
}
