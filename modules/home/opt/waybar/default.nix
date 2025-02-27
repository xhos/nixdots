{
  lib,
  config,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./backlight.nix
    ./audio.nix
    ./notification.nix
    ./network.nix
    ./general.nix
    ./power.nix

    ./style.nix
  ];

  stylix.targets.waybar.enable = false;

  wayland.windowManager.hyprland.settings = lib.mkIf (config.default.bar == "waybar") {
    exec = ["systemctl --user restart waybar"];
  };

  programs.waybar = lib.mkIf (config.default.bar == "waybar") {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "right";
        margin = "0 0 0 0";
        reload_style_on_change = true;
      };
    };
  };
}
