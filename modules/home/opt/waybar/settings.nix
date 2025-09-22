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
        DIR="/tmp/whisper-dictate"
        REC_PID="$DIR/recording.pid"
        TRN_FLAG="$DIR/transcribing.flag"

        # 1) Transcribing? (takes priority)
        if [[ -f "$TRN_FLAG" ]]; then
          echo '{"text":"💾 TXT","tooltip":"Transcribing…","class":"transcribing-active"}'
          exit 0
        fi

        # 2) Recording?
        if [[ -f "$REC_PID" ]] && kill -0 "$(cat "$REC_PID")" 2>/dev/null; then
          echo '{"text":"🎙️ REC","tooltip":"Recording…","class":"recording-active"}'
          exit 0
        fi

        # 3) Idle → hide
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

        # Path to the icons for notifications
        ICON_PATH="/etc/nixos/modules/home/opt/waybar/icons"

        # Directory where screen recordings will be saved
        DIRECTORY="$HOME/screenrecord"

        # Check if the directory exists
        if [ ! -d "$DIRECTORY" ]; then
            mkdir -p "$DIRECTORY"
        fi

        # Check if wf-recorder is running
        if pgrep -x "wf-recorder" > /dev/null; then
            # Gracefully stop wf-recorder by sending an interrupt signal
            pkill -INT -x wf-recorder
            notify-send -i "$ICON_PATH/recording-stop.png" -h string:wf-recorder:record -t 2500 "Finished Recording" "Saved at $DIRECTORY"
            
            # Update Waybar status using the correct Hyprland command
            hyprctl dispatch exec ${recording-status-script}/bin/recording-status
            
            exit 0
        fi

        # Get the list of available monitor names using hyprctl
        MONITORS=$(hyprctl monitors | grep "^Monitor " | awk '{print $2}')

        # Present the monitor list in rofi
        SELECTED_MONITOR=$(echo "$MONITORS" | rofi -dmenu -p "Record Monitor:")

        # Check if a monitor was selected
        if [ -n "$SELECTED_MONITOR" ]; then
            # Get the current date and time for the filename
            dateTime=$(date +%a-%b-%d-%y-%H-%M-%S)

            # Notify the user that recording will start on the selected monitor
            notify-send -i "$ICON_PATH/recording.png" -h string:wf-recorder:record -t 1500 "Recording Monitor" "Starting recording on: $SELECTED_MONITOR"

            # Start the screen recording on the selected output
            # The --bframes option is specific to certain ffmpeg encoders; may need adjustment
            wf-recorder -o "$SELECTED_MONITOR" -f "$DIRECTORY/$dateTime.mp4" &

        elif [ -z "$SELECTED_MONITOR" ]; then
            # User cancelled the rofi menu
            exit 0
        else
            notify-send -i "$ICON_PATH/recording.png" "Error" "No monitor selected."
            exit 1
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
      output = config.mainMonitor;
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
        "exec" = "${recording-status-script}/bin/recording-status";
        "return-type" = "json";
        "interval" = 1;
        "on-click" = "${recorder-script}/bin/recorder";
      };

      "custom/whisper" = {
        "exec" = "${whisper-status-script}/bin/whisper-status";
        "return-type" = "json";
        "interval" = 1;
        "on-click" = "whspr";
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
