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
    hyprctl dispatch exec /etc/nixos/modules/home/opt/waybar/scripts/recording_status.sh
    
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