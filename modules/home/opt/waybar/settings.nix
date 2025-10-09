{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.bar == "waybar") {
    programs.waybar.settings.main = let
lyrics-script = pkgs.writeShellApplication {
  name = "lyrics-line";
  runtimeInputs = with pkgs; [
    dejsonlz4
    jq
    playerctl
    curl
    perl
    coreutils
    (python3.withPackages (ps: [ ps.youtube-transcript-api ]))
  ];
  text = ''
    PLAYER="''${1:-spotify}"
    FIREFOX=~/.zen/hbvavekk.School/sessionstore-backups/recovery.jsonlz4
    CACHE_DIR=$HOME/.cache/lyrics
    LOCK_DIR=$HOME/.cache/lyrics/locks
    mkdir -p "$CACHE_DIR"
    mkdir -p "$LOCK_DIR"

    get_id() {
      url=$(dejsonlz4 "$FIREFOX" | jq -r ".windows[0].tabs | sort_by(.lastAccessed)[-1] | .entries[.index-1] | .url")

      if [[ "$url" =~ ^https://www\.youtube\.com/watch\?v= ]]; then
        echo "$url" | perl -pe 's|https:\/\/www\.youtube\.com\/watch\?v=||'
      else
        echo "Error: The URL is not from YouTube." >&2
        return 1
      fi
    }

    trim() {
      local var="$*"
      var="''${var#"''${var%%[![:space:]]*}"}"
      var="''${var%"''${var##*[![:space:]]}"}"
      printf '%s' "$var"
    }

    hash() {
      echo -n "$1" | md5sum | awk '{print $1}'
    }

    acquire_lock() {
      local lock_name="$1"
      local lock_file="$LOCK_DIR/$lock_name.lock"
      local max_wait=30
      local waited=0

      while ! mkdir "$lock_file" 2>/dev/null; do
        if [ $waited -ge $max_wait ]; then
          echo "Timeout waiting for lock: $lock_name" >&2
          return 1
        fi

        sleep 0.5
        waited=$((waited + 1))
      done

      echo $$ >"$lock_file/pid"
      # shellcheck disable=SC2064
      trap "rm -rf '$lock_file' 2>/dev/null || true" EXIT

      return 0
    }

    release_lock() {
      local lock_name="$1"
      local lock_file="$LOCK_DIR/$lock_name.lock"

      rm -rf "$lock_file" 2>/dev/null || true
      trap - EXIT
    }

    fetch_with_cache() {
      uri="$1"
      lock_name=$(hash "$uri")
      file_path="$CACHE_DIR/$(hash "$uri")"

      if [ -f "$file_path" ]; then
        res=$(cat "$file_path")
        echo "$res"
      else
        if ! acquire_lock "$lock_name"; then
          if [ -f "$file_path" ]; then
            res=$(cat "$file_path")
            echo "$res"
            return 0
          fi
          return 1
        fi

        if [ -f "$file_path" ]; then
          res=$(cat "$file_path")
          echo "$res"
          release_lock "$lock_name"
          return 0
        fi

        res=$(curl -s "$1")

        if [[ -z "$res" ]]; then
          release_lock "$lock_name"
          return 1
        fi

        echo "$res" >"$file_path"
        echo "$res"

        release_lock "$lock_name"
      fi
    }

    get_title_artists() {
      playerctl -p "$PLAYER" metadata --format "{{title}} {{artist}}" | jq -sRr @uri
    }

    lrclib() {
      url="https://lrclib.net/api/search?q=$(get_title_artists)"
      fetch_with_cache "$url" | jq ".[0].syncedLyrics" -r
    }

    netease() {
      song_id=$(fetch_with_cache "https://music.xianqiao.wang/neteaseapiv2/search?limit=10&type=1&keywords=$(get_title_artists)" | jq ".result.songs[0].id")
      fetch_with_cache "https://music.xianqiao.wang/neteaseapiv2/lyric?id=$song_id" | jq ".lrc.lyric" -r
    }

    get_position() {
      playerctl -p "$PLAYER" metadata --format "{{position}}"
    }

    convert_to_microseconds() {
      local timestamp=$1
      timestamp=''${timestamp//[\[\]]/}

      IFS=":." read -r minutes seconds milliseconds <<<"$timestamp"

      minutes=''${minutes#0}
      seconds=''${seconds#0}
      milliseconds=''${milliseconds#0}

      [ -z "$minutes" ] && minutes=0
      [ -z "$seconds" ] && seconds=0
      [ -z "$milliseconds" ] && milliseconds=0

      local total_microseconds=$(((\
        minutes * 60 * 1000000) + (\
        seconds * 1000000) + (\
        milliseconds * 1000)))

      echo "$total_microseconds"
    }

    current_line() {
      prev=""
      position=$1
      while IFS= read -r line; do
        [ -z "$line" ] && continue

        if [[ $line =~ ^\[[0-9:.]+\] ]]; then
          timestamp=''${line%%\]*}"]"
          content=''${line#*]}

          microseconds=$(convert_to_microseconds "$timestamp")

          if ((position < microseconds)); then
            trim "$prev"
            return
          fi
          prev=$content
        fi
      done
    }

    youtube() {
      id=$1
      lock_name="youtube_$id"
      file_path="$CACHE_DIR/$id"

      if [ -f "$file_path" ]; then
        res=$(cat "$file_path")
        echo "$res"
      else
        if ! acquire_lock "$lock_name"; then
          if [ -f "$file_path" ]; then
            res=$(cat "$file_path")
            echo "$res"
            return 0
          fi
          return 1
        fi

        if [ -f "$file_path" ]; then
          res=$(cat "$file_path")
          echo "$res"
          release_lock "$lock_name"
          return 0
        fi

        if res=$(python3 <<EOF
from youtube_transcript_api import YouTubeTranscriptApi
from youtube_transcript_api.formatters import TextFormatter

def convert_to_timestamp_format(seconds):
  """Convert seconds to [MM:SS.MS] format"""
  minutes = seconds // 60
  seconds_remainder = seconds % 60
  return f"[{minutes:02d}:{seconds_remainder:05.2f}]"

def convert_json_to_timestamp_format(json_str):
  formatted_lines = []
  for entry in json_str:
    timestamp = convert_to_timestamp_format(int(entry['start']))
    formatted_lines.append(f"{timestamp} {entry['text']}")
  return '\n'.join(formatted_lines)

t = YouTubeTranscriptApi.get_transcript('$id')

print(convert_json_to_timestamp_format(t), end='\n')
EOF
        ); then
          echo "$res" >"$file_path"
        fi

        release_lock "$lock_name"
        echo "$res"
      fi
    }

    handle_player() {
      local player="$1"
      local album

      if [ -z "''${PRINT_PLAYER:-}" ]; then
        :
      else
        echo "$player"
      fi

      case "$player" in
        spotify | .spotify-wrappe)
          PLAYER=spotify
          if ! lrclib | current_line "$(get_position)"; then
            playerctl metadata --format "{{title}} - {{artist}}"
          fi
          ;;
        spotifyd | spotifyd*)
          PLAYER=spotifyd
          if ! lrclib | current_line "$(get_position)"; then
            playerctl metadata --format "{{title}} - {{artist}}"
          fi
          ;;
        spotify_player | spotify_player*)
          PLAYER=spotify_player
          if ! lrclib | current_line "$(get_position)"; then
            playerctl metadata --format "{{title}} - {{artist}}"
          fi
          ;;
        chromium)
          PLAYER=chromium
          album=$(playerctl -p $PLAYER metadata xesam:album | tr -d '\n')
          if [ -z "$album" ]; then
            playerctl -p $PLAYER metadata --format "{{title}} {{artist}}"
          else
            lrclib | current_line "$(get_position)"
          fi
          ;;
        firefox)
          PLAYER=firefox
          album=$(playerctl -p $PLAYER metadata xesam:album | tr -d '\n')
          if [ -z "$album" ]; then
            if id=$(get_id); then
              subs=$(youtube "$id")
              echo "$subs" | current_line "$(get_position)"
            fi
          else
            lrclib | current_line "$(get_position)"
          fi
          ;;
      esac
    }

    for player in $(playerctl -l 2>/dev/null); do
      if [ "$(playerctl -p "$player" status 2>/dev/null)" = "Playing" ]; then
        handle_player "$player"
        exit 0
      fi
    done

    declare -A fallback=(
      ["spotifyd"]="spotifyd"
      ["spotify"]="spotify .spotify-wrapper"
      ["spotify_player"]="spotify_player"
      ["chromium"]="google-chrome-stable"
      ["firefox"]="firefox .zen-wrapped .zen-twilight-w zen"
    )

    for player in "''${!fallback[@]}"; do
      read -ra procs <<<"''${fallback[$player]}"
      for proc in "''${procs[@]}"; do
        if pgrep -fx "$proc" 2>/dev/null >/dev/null || pgrep -x "$proc" 2>/dev/null >/dev/null; then
          handle_player "$player"
          exit 0
        fi
      done
    done
  '';
};

      zfs-script = pkgs.writeShellApplication {
        name = "zfs-status";
        runtimeInputs = with pkgs; [ zfs coreutils gnugrep gawk ];
        text = ''
          pool="rpool"

          read -r used avail <<<"$(zpool list -Hp -o allocated,free "$pool")"

          total=$((used + avail))
          pct=$((used * 100 / total))

          to_human() { numfmt --to=iec --suffix=B "$1"; }

          used_hr=$(to_human "$used")
          total_hr=$(to_human "$total")

          printf '{"text":"zfs: %s%%","tooltip":"%s / %s"}\n' "$pct" "$used_hr" "$total_hr"
        '';
      };

      whisper-status-script = pkgs.writeShellApplication {
        name = "whisper-status";
        runtimeInputs = with pkgs; [ coreutils ];
        text = ''
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
      };

      recording-status-script = pkgs.writeShellApplication {
        name = "recording-status";
        runtimeInputs = with pkgs; [ procps ];
        text = ''
          if pgrep -x "wf-recorder" > /dev/null; then
            echo '{"text": "🔴 REC", "tooltip": "Recording active", "class": "recording-active"}'
          else
            echo '{"text": "", "tooltip": "", "class": "recording-inactive"}'
          fi
        '';
      };

      recorder-script = pkgs.writeShellApplication {
        name = "recorder";
        runtimeInputs = with pkgs; [ wf-recorder rofi libnotify hyprland procps gawk coreutils ];
        text = ''
          DIRECTORY="$HOME/screenrecord"

          if [ ! -d "$DIRECTORY" ]; then
              mkdir -p "$DIRECTORY"
          fi

          if pgrep -x "wf-recorder" > /dev/null; then
              pkill -INT -x wf-recorder
              notify-send -h string:wf-recorder:record -t 2500 "Finished Recording" "Saved at $DIRECTORY"
              ${recording-status-script}/bin/recording-status
              exit 0
          fi

          MONITORS=$(hyprctl monitors | grep "^Monitor " | awk '{print $2}')
          SELECTED_MONITOR=$(echo "$MONITORS" | rofi -dmenu -p "Record Monitor:")

          if [ -n "$SELECTED_MONITOR" ]; then
              dateTime=$(date +%a-%b-%d-%y-%H-%M-%S)
              notify-send -h string:wf-recorder:record -t 1500 "Recording Monitor" "Starting recording on: $SELECTED_MONITOR"
              wf-recorder -o "$SELECTED_MONITOR" -f "$DIRECTORY/$dateTime.mp4" &
          elif [ -z "$SELECTED_MONITOR" ]; then
              exit 0
          else
              notify-send "Error" "No monitor selected."
              exit 1
          fi
        '';
      };

      camera-cover-script = pkgs.writeShellApplication {
        name = "camera-cover-status";
        runtimeInputs = with pkgs; [ coreutils ];
        text = ''
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
      };
    in {
      "modules-left" = [
        "hyprland/workspaces"
        "group/stats"
      ];

      "modules-center" = [
        "clock"
        "custom/lyrics"
        "mpris"
      ];

      "modules-right" = [
        "network"
        "bluetooth"
        "pulseaudio#microphone"
        "pulseaudio"
        "backlight"
        "battery"
        "custom/recording"
        "custom/whisper"
        "custom/camera-cover"
      ];

      "hyprland/workspaces" = {
        "format" = "{icon}";
        "on-click" = "activate";
        "format-icons" = {
          "1" = "一";
          "2" = "二";
          "3" = "三";
          "4" = "四";
          "5" = "五";
          "6" = "六";
          "7" = "七";
          "8" = "八";
          "9" = "九";
          "10" = "十";
          "11" = "一";
          "12" = "二";
          "13" = "三";
          "14" = "四";
          "15" = "五";
          "16" = "六";
          "17" = "七";
          "18" = "八";
          "19" = "九";
          "20" = "十";
        };
      };

      "group/stats" = {
        "orientation" = "inherit";
        "drawer" = {
          "transition-duration" = 200;
          "transition-left-to-right" = true;
        };
        "modules" = [
          "cpu"
          "disk#root"
          "disk#games"
          "custom/zfs"
        ];
      };

      "cpu" = {
        "format" = "cpu: {usage}%";
        "interval" = 1;
        "tooltip" = true;
      };

      "disk#root" = {
        "interval" = 30;
        "format" = "root: {percentage_used}%";
        "tooltip-format" = "{used} / {total}";
        "path" = "/";
      };

      "disk#games" = {
        "interval" = 30;
        "format" = "games: {percentage_used}%";
        "tooltip-format" = "{used} / {total}";
        "path" = "/games";
      };

      "custom/zfs" = {
        "exec" = "${zfs-script}/bin/zfs-status";
        "interval" = 30;
        "return-type" = "json";
      };

      "custom/lyrics" = {
        "format" = " {}";
        "interval" = 1;
        "exec" = "${lyrics-script}/bin/lyrics-line";
        "max-length" = 50;
      };

      "clock" = {
        "interval" = 1;
        "format" = "{:%H:%M}";
        "format-alt" = "{:%a, %b %d}";
        "tooltip-format" = "<tt><small>{calendar}</small></tt>";
      };

      "mpris" = {
        "format" = "{status_icon}";
        "format-paused" = "{status_icon}";
        "status-icons" = {
          "playing" = "󰐊";
          "paused" = "󰏤";
          "stopped" = "󰓛";
        };
        "interval" = 1;
        "on-click" = "playerctl play-pause";
        "on-click-right" = "playerctl next";
        "on-click-middle" = "playerctl previous";
        "tooltip" = true;
        "tooltip-format" = "{title}";
      };

      "network" = {
        "format-wifi" = "wifi: {essid}";
        "format-ethernet" = "eth: {ipaddr}";
        "format-disconnected" = "wifi: disconnected";
        "format-disabled" = "wifi: disabled";
        "interval" = 5;
        "tooltip-format" = "{essid}\t{gwaddr}";
        "tooltip" = true;
        "max-length" = 20;
      };

      "bluetooth" = {
        "interval" = 5;
        "format-on" = "󰂯 on";
        "format-off" = "󰂲 off";
        "format-disabled" = "󰂲 disabled";
        "format-connected" = "󰂱 {device_alias}";
        "tooltip" = true;
        "tooltip-format" = "{device_enumerate}";
        "tooltip-format-enumerate-connected" = "{device_address}";
        "tooltip-format-enumerate-connected-battery" = "{device_address} | Battery: {device_battery_percentage}%";
      };

      "pulseaudio#microphone" = {
        "format" = "mic: {format_source}";
        "format-source" = "{volume}%";
        "format-source-muted" = "mute";
        "on-click" = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "tooltip" = true;
        "tooltip-format" = "Microphone: {volume}%\n{desc}";
      };

      "pulseaudio" = {
        "interval" = 2;
        "format" = "vol: {volume}%";
        "format-muted" = "vol: mute";
        "on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "reverse-scrolling" = true;
        "tooltip" = true;
        "tooltip-format" = "Volume: {volume}%\n{desc}";
      };

      "backlight" = {
        "device" = "intel_backlight";
        "format" = "led: {percent}%";
        "reverse-scrolling" = true;
        "smooth-scrolling-threshold" = 0.1;
        "tooltip" = false;
      };

      "battery" = {
        "interval" = 5;
        "states" = {
          "full" = 100;
          "notfull" = 99;
          "warning" = 20;
          "critical" = 10;
        };
        "format-charging" = "bat: {capacity}% chg";
        "format-full" = "bat: {capacity}% full";
        "format-notfull" = "bat: {capacity}% dc";
        "format-plugged" = "bat: {capacity}% ac";
        "format-warning" = "bat: {capacity}% low";
        "format-critical" = "bat: {capacity}% crit";
        "tooltip" = false;
      };

      "custom/camera-cover" = {
        "exec" = "${camera-cover-script}/bin/camera-cover-status";
        "interval" = 1;
        "return-type" = "json";
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
    };
  };
}