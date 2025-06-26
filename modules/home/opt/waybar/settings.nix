{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.default.bar == "waybar") {
    programs.waybar.settings.main = let
      whisper-status-script = pkgs.writeShellScriptBin "whisper-status" ''
        #!/usr/bin/env bash
        PIDFILE="/tmp/whisper-dictate/recording.pid"

        # Check if the PID file exists and the process ID inside is still running
        if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
          # If recording, output JSON for Waybar
          echo '{"text": "🎙️ REC", "tooltip": "Whisper is recording...", "class": "recording-active"}'
        else
          # If not recording, output empty JSON to hide the module
          echo '{}'
        fi
      '';
    in {
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
        "custom/whisper"
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
        format = "{:%H:%M}";
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

      "custom/whisper" = {
        "exec" = "${whisper-status-script}/bin/whisper-status";
        "return-type" = "json";
        "interval" = 1;
        "on-click" = "whisper-dictate";
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
