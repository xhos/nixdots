{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.default.bar == "waybar") {
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

          modules-right = ["group/together" "clock"];
          "group/together" = {
            orientation = "inherit";
            modules = [
              "group/utils"
              "group/connection"
              "custom/notifications"
              "group/brightness"
              "group/audio"
              "custom/hyprsunset"
              "hyprland/language"
              "battery"
              # "custom/wl-gammarelay-temperature"
            ];
          };
          "group/utils" = {
            orientation = "inherit";
            drawer = {
              transition-duration = 500;
              transition-left-to-right = true;
            };
            modules = [
              "custom/mark"
              "tray"
            ];
          };

          tray = {
            icon-size = 18;
            spacing = 10;
          };

          "custom/mark" = {
            format = "";
            tooltip = false;
          };

          "custom/hyprsunset" = {
            format = '''';
            exec = "hyprsunset -t 6600";
            on-scroll-up = "hyprsunset -t 6600";
            on-scroll-down = "hyprsunset -t 2500";
          };

          "hyprland/language" = {
            format = "{}";
            format-en = "🦅";
            format-ru = "🐻";
            keyboard-name = "at-translated-set-2-keyboard";
          };

          clock = {
            format = ''
              {:%H
              %M}'';
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "month";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              on-click-right = "mode";
              format = {today = "<span color='#a6e3a1'><b><u>{}</u></b></span>";};
            };
          };

          battery = lib.mkIf (!config.modules.nvidia.enable) {
            rotate = 270;
            states = {
              good = 90;
              warning = 30;
              critical = 15;
            };
            format = "{icon}";
            format-charging = "<b>{icon} </b>";
            format-full = "<span color='#82A55F'><b>{icon}</b></span>";
            format-icons = ["󰁻" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹"];
            tooltip-format = "{timeTo} {capacity} % | {power} W";
          };
        };
      };
    };
  };
}
