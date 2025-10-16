{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.bar == "waybar") {
    programs.waybar.style = with config.lib.stylix.colors; ''
      @define-color background #000000;
      @define-color foreground #${base08};
      @define-color text #${base05};

      @define-color color0 #${base00};
      @define-color color1 #${base01};
      @define-color color2 #${base02};
      @define-color color3 #${base03};
      @define-color color4 #${base04};
      @define-color color5 #${base05};
      @define-color color6 #${base06};
      @define-color color7 #${base07};
      @define-color color8 #${base0D};
      @define-color color9 #${base05};
      @define-color color10 #${base0C};
      @define-color color11 #${base0B};
      @define-color color12 #${base0C};
      @define-color color13 #${base0C};
      @define-color color14 #${base0E};
      @define-color color15 #${base08};
      @define-color active #${base0C};
      @define-color inactive #${base03};

      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        border: none;
        min-height: 0;
      }

      window#waybar {
        background: @background;
        color: @text;
      }

      #cpu,
      #clock,
      #disk,
      #mpris,
      #network,
      #custom-zfs,
      #bluetooth,
      #pulseaudio,
      #pulseaudio.microphone,
      #backlight,
      #battery,
      #custom-recording,
      #custom-whisper,
      #custom-camera-cover {
        padding: 0 8px;
        margin: 0 2px;
        color: @text;
      }

      #workspaces button {
        color: @inactive;
        padding: 0 4px;
      }

      #workspaces button.active {
        color: #${base07};
      }

      #mpris.playing { color: @color11; }
      #mpris.paused { color: #${base0A}; }
      #mpris.stopped { color: @inactive; }

      #network.disabled { color: @inactive; }

      #bluetooth.disabled { color: @inactive; }

      #pulseaudio.sink-muted:not(.microphone) { color: #${base08}; }
      #pulseaudio.microphone.source-muted { color: @inactive; }

      #battery.plugged,
      #battery.full { color: @color11; }
      #battery.charging { color: @color11; }
      #battery.warning { color: #${base0A}; }
      #battery.critical { color: #${base08}; }

      #custom-recording.recording-active,
      #custom-whisper.recording-active {
        color: #${base08};
      }

      #custom-whisper.transcribing-active {
        color: #${base0A};
      }

      tooltip {
        background: @background;
        color: @text;
        border: 1px solid #${base02};
      }
    '';
  };
}
