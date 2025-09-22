{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.default.bar == "waybar") {
    programs.waybar.settings.main = let
      iconPath = "/etc/nixos/modules/home/opt/waybar/icons";
      
      whisper-status-script = pkgs.writeShellScriptBin "whisper-status" ''
        #!/usr/bin/env bash
        DIR="/tmp/whisper-dictate"
        REC_PID="$DIR/recording.pid"
        TRN_FLAG="$DIR/transcribing.flag"

        if [[ -f "$TRN_FLAG" ]]; then
          echo '{"text":"💾 TXT","tooltip":"Transcribing…","class":"transcribing-active"}'
          exit 0
        fi

        if [[ -f "$REC_PID" ]] && kill -0 "$(cat "$REC_PID")" 2>/dev/null; then
          echo '{"text":"🎙️ REC","tooltip":"Recording…","class":"recording-active"}'
          exit 0
        fi

        echo '{}'
      '';

      recording-status-script = pkgs.writeShellScriptBin "recording-status" ''
        #!/usr/bin/env bash

        if pgrep -x "wf-recorder" > /dev/null; then
          echo '{"text": "🔴 REC", "tooltip": "Recording active", "class": "recording-active"}'
        else
          echo '{"text": "", "tooltip": "", "class": "recording-inactive"}'
        fi
      '';

      recorder-script = pkgs.writeShellScriptBin "recorder" ''
        #!/usr/bin/env bash

        ICON_PATH="${iconPath}"
        DIRECTORY="$HOME/screenrecord"

        if [ ! -d "$DIRECTORY" ]; then
            mkdir -p "$DIRECTORY"
        fi

        if pgrep -x "wf-recorder" > /dev/null; then
            pkill -INT -x wf-recorder
            notify-send -i "$ICON_PATH/recording-stop.png" -h string:wf-recorder:record -t 2500 "Finished Recording" "Saved at $DIRECTORY"
            hyprctl dispatch exec ${recording-status-script}/bin/recording-status
            exit 0
        fi

        MONITORS=$(hyprctl monitors | grep "^Monitor " | awk '{print $2}')
        SELECTED_MONITOR=$(echo "$MONITORS" | rofi -dmenu -p "Record Monitor:")

        if [ -n "$SELECTED_MONITOR" ]; then
            dateTime=$(date +%a-%b-%d-%y-%H-%M-%S)
            notify-send -i "$ICON_PATH/recording.png" -h string:wf-recorder:record -t 1500 "Recording Monitor" "Starting recording on: $SELECTED_MONITOR"
            wf-recorder -o "$SELECTED_MONITOR" -f "$DIRECTORY/$dateTime.mp4" &
        elif [ -z "$SELECTED_MONITOR" ]; then
            exit 0
        else
            notify-send -i "$ICON_PATH/recording.png" "Error" "No monitor selected."
            exit 1
        fi
      '';

      camera-cover-script = pkgs.writeShellScriptBin "camera-cover-status" ''
        #!/usr/bin/env bash
        ATTR_FILE="/sys/class/firmware-attributes/samsung-galaxybook/attributes/block_recording/current_value"
        CACHE_FILE="/tmp/.camera_cover_unavailable"

        if [ -f "$CACHE_FILE" ]; then
            echo '{}'
            exit 0
        fi

        if [ ! -f "$ATTR_FILE" ]; then
            touch "$CACHE_FILE"
            echo '{}'
            exit 0
        fi

        value=$(cat "$ATTR_FILE" 2>/dev/null)

        if [ "$value" = "0" ]; then
            echo '{"text": "🔴", "tooltip": "Camera cover open", "class": "camera-open"}'
        else
            echo '{"text": "", "tooltip": "Camera cover closed", "class": "camera-closed"}'
        fi
      '';
    in {
      "battery" = {
        "format" = "{icon}   {capacity}";
        "format-alt" = "{time}   {icon}";
        "format-charging" = "󰋠   {capacity}";
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
        "format-plugged" = "󰋠    {capacity}";
        "states" = {
          "critical" = 20;
          "good" = 95;
          "warning" = 30;
        };
      };
      "bluetooth" = {
        "format" = "󰂯    {status}";
        "format-connected" = " {num_connections}";
        "format-disabled" = " off";
        "on-click" = "kitty -e bluetui";
        "tooltip-format" = "{device_alias}";
        "tooltip-format-connected" = " {device_enumerate}";
        "tooltip-format-enumerate-connected" = "{device_alias}";
      };
      "clock" = {
        "calendar" = {
          "format" = {
            "months" = "<span color='#ffead3'><b>{}</b></span>";
            "today" = "<span color='#ffcc66'><b><u>{}</u></b></span>";
            "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
          };
        };
        "format" = "{:%H:%M}";
        "tooltip-format" = "<tt><small>{calendar}</small></tt>";
      };
      "custom/recording" = {
        "exec" = "${recording-status-script}/bin/recording-status";
        "interval" = 1;
        "on-click" = "${recorder-script}/bin/recorder";
        "return-type" = "json";
      };
      "custom/whisper" = {
        "exec" = "${whisper-status-script}/bin/whisper-status";
        "interval" = 1;
        "on-click" = "whspr";
        "return-type" = "json";
      };
      "custom/camera-cover" = {
        "exec" = "${camera-cover-script}/bin/camera-cover-status";
        "interval" = 1;
        "return-type" = "json";
      };
      "group/clock-connectivity" = {
        "drawer" = {
          "transition-duration" = 500;
          "transition-left-to-right" = true;
        };
        "modules" = [
          "clock"
          "bluetooth"
          "network"
        ];
        "orientation" = "inherit";
      };
      "fixed center" = true;
      "height" = 34;
      "hyprland/workspaces" = {
        "active-only" = false;
        "all-outputs" = false;
        "format" = "{icon}";
        "format-icons" = {
          "active" = "󰫢 ";
          "default" = "󰫣 ";
        };
        "on-click" = "activate";
        "on-scroll-down" = "hyprctl dispatch workspace e-1";
        "on-scroll-up" = "hyprctl dispatch workspace e+1";
        "show-special" = false;
        "sort-by-number" = true;
        "window-rewrite" = {};
      };
      "layer" = "top";
      "margin" = "5 10 0";
      "modules-center" = [
        "hyprland/workspaces"
      ];
      "modules-left" = [
        "group/clock-connectivity"
        "custom/recording"
        "custom/whisper"
        "custom/camera-cover"
      ];
      "modules-right" = [
        "tray"
      ];
      "network" = {
        "format-disconnected" = "󰖪 ";
        "format-ethernet" = "{ipaddr}/{cidr}";
        "format-linked" = "{ifname} (No IP)";
        "format-wifi" = "    {signalStrength}%";
        "on-click" = "exec ~/.config/rofi/assets/wifimenu --rofi -s";
        "tooltip-format" = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({bandwidthDownBytes})</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>";
      };
      "tray" = {
        "icon-size" = 18;
        "spacing" = 5;
      };
      "output" = config.mainMonitor;
      "position" = "top";
      "reload_style_on_change" = true;
      "width" = 500;
    };
  };
}
