{
  lib,
  config,
  ...
}: {
  imports = [
    ./style.nix
    ./settings.nix
  ];

  config = lib.mkIf (config.default.bar == "waybar") {
    wayland.windowManager.hyprland.settings.exec-once = lib.mkIf (config.default.de == "hyprland") ["waybar"];
    programs.waybar.enable = true;
  };
}
