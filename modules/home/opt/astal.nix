{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [inputs.aard.homeManagerModules.aard];

  config = lib.mkIf (config.default.bar == "astal") {
    programs.aard = {
      enable = true;
      wallpaper = config.stylix.image;
      transparency = true;
      systemd.enable = true;
    };
  };
}
