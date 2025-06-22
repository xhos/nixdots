{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.default.bar == "waybar") {
    programs.waybar.settings.main = {
      layer = "top";
      position = "top";
      margin = "5 10 0";
      "fixed center" = true;
      reload_style_on_change = true;
      height = 34;
      width = 500;
      "modules-left" = [
        "clock"
        "custom/recording"
      ];
      "modules-center" = ["hyprland/workspaces"];
      "modules-right" = ["group/custom-group"];

      "hyprland/workspaces" = {
        "active-only" = false;
        "all-outputs" = false;
        format = "{icon}";
        "format-icons" = {
          active = "󰫢 ";
          default = "󰫣 ";
        };
        "on-click" = "activate";
        "on-scroll-down" = "hyprctl dispatch workspace e-1";
        "on-scroll-up" = "hyprctl dispatch workspace e+1";
        "show-special" = false;
        "sort-by-number" = true;
        "window-rewrite" = {};
      };

      clock = {
        format = "{:%I:%M %p}";
        "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        calendar = {
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ffcc66'><b><u>{}</u></b></span>";
          };
        };
      };

      battery = {
        states = {
          good = 95;
          warning = 30;
          critical = 20;
        };
        format = "{icon}   {capacity}";
        "format-charging" = "󰋠   {capacity}";
        "format-plugged" = "󰋠    {capacity}";
        "format-alt" = "{time}   {icon}";
        "format-icons" = [
          "󱢠 󱢠 󱢠 "
          "󱢠 󱢠 󰛞 "
          "󱢠 󱢠 󰛞 "
          "󱢠 󱢠 󰋑 "
          "󱢠 󰛞 󰋑 "
          "󱢠 󰛞 󰋑 "
          "󱢠 󰋑 󰋑 "
          "󰛞 󰋑 󰋑 "
          "󰛞 󰋑 󰋑 "
          "󰋑 󰋑 󰋑 "
        ];
      };

      network = {
        "format-wifi" = "    {signalStrength}%";
        "format-ethernet" = "{ipaddr}/{cidr}";
        "format-linked" = "{ifname} (No IP)";
        "format-disconnected" = "󰖪 ";
        "on-click" = "exec ~/.config/rofi/assets/wifimenu --rofi -s";
        "tooltip-format" = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({bandwidthDownBytes})</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>";
      };

      bluetooth = {
        format = "󰂯    {status}";
        "format-disabled" = " off";
        "format-connected" = " {num_connections}";
        "tooltip-format" = "{device_alias}";
        "tooltip-format-connected" = " {device_enumerate}";
        "tooltip-format-enumerate-connected" = "{device_alias}";
        "on-click" = "kitty -e bluetui";
      };

      "custom/recording" = {
        "exec" = "/etc/nixos/modules/home/opt/waybar/scripts/recording_status.sh";
        "return-type" = "json";
        "interval" = 1;
        "on-click" = "bash /etc/nixos/modules/home/opt/waybar/scripts/recorder.sh";
      };

      "group/custom-group" = {
        orientation = "inherit";
        drawer = {
          "transition-duration" = 500;
          "transition-left-to-right" = false;
        };
        modules = ["battery" "bluetooth" "network"];
      };
    };
  };
}
