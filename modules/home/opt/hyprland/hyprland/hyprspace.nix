{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.default.de == "hyprland" && config.hyprland.hyprspace.enable) {
    wayland.windowManager.hyprland = {
      plugins = [pkgs.hyprlandPlugins.hyprspace];
      settings.bind = ["SUPER, Tab, overview:toggle"];
    };
  };
}
