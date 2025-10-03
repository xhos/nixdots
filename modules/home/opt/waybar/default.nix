{
  lib,
  config,
  ...
}: {
  imports = [
    ./style.nix
    ./settings.nix
  ];

  config = lib.mkIf (config.bar == "waybar") {
    wayland.windowManager.hyprland.settings.exec-once = lib.mkIf (config.de == "hyprland") ["waybar"];
    programs.waybar.enable = true;
  };
}
