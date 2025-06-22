{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./style.nix
    ./settings.nix
  ];

  config = lib.mkIf (config.default.bar == "waybar") {
    wayland.windowManager.hyprland.settings.exec-once = lib.mkIf (config.default.de == "hyprland") ["waybar"];
    programs.waybar.enable = true;
    home.packages = with pkgs; [
      wf-recorder
      procps # for pgrep/pkill
      libnotify # for notify-send
      rofi-wayland
      sway # for swaymsg
    ];
  };
}
