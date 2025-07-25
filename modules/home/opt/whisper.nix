{
  pkgs,
  lib,
  config,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      ctranslate2 = prev.ctranslate2.override {
        withCUDA = true;
        withCuDNN = true;
      };
    })
  ];

  home.packages = lib.mkIf config.modules.whisper.enable [
    (pkgs.writeShellApplication {
      name = "whspr";
      runtimeInputs = with pkgs; [whisper-ctranslate2 sox wl-clipboard coreutils];
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        DIR="/tmp/whisper-dictate"
        AUDIO="$DIR/recording.wav"
        REC_PID="$DIR/recording.pid"
        TRN_FLAG="$DIR/transcribing.flag"
        TEXT="$DIR/recording.txt"
        mkdir -p "$DIR"

        # stop
        if [[ -f "$REC_PID" && -s "$REC_PID" ]] && kill -0 "$(cat "$REC_PID")" 2>/dev/null; then
          kill "$(cat "$REC_PID")" && rm -f "$REC_PID"
          until [[ -s "$AUDIO" ]]; do sleep 0.1; done

          notify-send "Whisper" "Transcribing…" -t 1500
          touch "$TRN_FLAG"

          whisper-ctranslate2 "$AUDIO" \
            --model large-v3 --language ru \
            --device cuda --compute_type float16 \
            --output_format txt --output_dir "$DIR"

          if [[ -s "$TEXT" ]]; then
            wl-copy < "$TEXT"
            notify-send "Whisper" "Copied to clipboard" -t 2000
          else
            notify-send "Whisper" "No speech detected" -t 2000
          fi

          rm -f "$AUDIO" "$TEXT" "$TRN_FLAG"
          exit 0
        fi

        # start
        notify-send "Whisper" "Recording… press hotkey again to stop" -t 1500
        sox -q -v 0.7 -d -r 16000 -c 1 -b 16 "$AUDIO" &
        echo $! > "$REC_PID"
        until [[ -s "$AUDIO" ]]; do sleep 0.05; done
      '';
    })
  ];
}
