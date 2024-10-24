{
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

  wayland.windowManager.hyprland.settings = {
    exec = ["systemctl --user restart waybar"];
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "right";
        margin = "10 5 10 0";
        reload_style_on_change = true;
      };
    };
  };
}
