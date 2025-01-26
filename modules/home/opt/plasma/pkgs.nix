{
  pkgs,
  lib,
  config,
  ...
}: {
  home = lib.mkIf (config.default.de == "plasma") {
    packages = with pkgs; [
      linux-wallpaperengine
      plasma-panel-colorizer
    ];
  };
}
