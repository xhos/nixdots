{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.default.bar == "waybar") {
    programs.waybar.style = with config.lib.stylix.colors; ''
      @define-color bg #${base00};
      @define-color fg #${base05};
      @define-color accent #${base0D};
      @define-color recording #${base08};
      @define-color urgent #${base0E};

      * {
        border: none;
        border-radius: 0px;
        font-family: 'Ndot55, DepartureMono Nerd Font';
        font-weight: bold;
        font-size: 15px;
        min-height: 0;
      }

      window#waybar {
        border-radius: 20px;
        background: alpha(@bg, 0.05);
      }

      tooltip {
        background: alpha(@bg, 0.3);
        border-radius: 10px;
        border: 2px solid alpha(lighter(@accent), 0.3);
      }

      tooltip label {
        color: @foreground;
      }

      #workspaces {
        background: alpha(@bg, 0.2);
        border-radius: 20px;
        margin-top: 4px;
        margin-bottom: 4px;
      }

      #workspaces button {
        padding: 0px;
        color: alpha(@foreground, 0.5);
        background: transparent;
        border-radius: 10px;
        margin-top: 3px;
        margin-bottom: 3px;
        padding-left: 3px;
        padding-right: 3px;
        animation: gradient_f 20s ease-in infinite;
        transition: all 0.4s cubic-bezier(0.55, -0.68, 0.48, 1.682);
      }

      #workspaces button.active {
        background: alpha(@bg, 0.2);
        color: lighter(@accent);
        border-radius: 20px;
        transition: color 0.5s;
        margin-left: 3px;
        padding-left: 15px;
        padding-right: 15px;
        border-bottom: 2px solid @fg;
        margin-right: 3px;
        animation: gradient_f 20s ease-in infinite;
        transition: all 0.8s cubic-bezier(0.55, -0.68, 0.48, 1.682);
      }

      #workspaces button.focused {
        color: @fg;
        background: transparent;
      }

      #workspaces button.urgent {
        color: @fg;
        background: transparent;
      }

      #workspaces button:hover {
        background: transparent;
        color: @fg;
      }

      #window,
      #clock,
      #battery,
      #network,
      #memory,
      #custom-recording,
      #custom-whisper,
      #bluetooth,
      #workspaces {
        padding: 0px 14px 0px 14px;
      }

      #custom-whisper.recording-active,
      #custom-recording.recording-active {
        color: #fa5252;
        background-color: alpha(@bg, 0.2);
        border-radius: 20px;
        padding: 0 10px;
        margin-top: 4px;
        margin-bottom: 4px;
        margin-left: 3px;
        font-weight: bold;
        animation: pulse 2s infinite;
      }

      #custom-whisper.recording-inactive,
      #custom-recording.recording-inactive {
        color: transparent;
        background-color: transparent;
        border: none;
        padding: 0;
        margin: 0;
        min-width: 0;
        min-height: 0;
      }

      #custom-whisper.transcribing-active {
        color:#f7fa52;
        background-color: alpha(@bg, 0.2);
        border-radius: 20px;
        padding: 0 10px;
        margin-top: 4px; margin-bottom: 4px; margin-left: 3px;
        font-weight: bold;
        animation: pulse 1.5s infinite;
      }

      @keyframes pulse {
        0% {
          opacity: 1;
        }

        50% {
          opacity: 0.7;
        }

        100% {
          opacity: 1;
        }
      }

      #window {
        margin-left: 60px;
        margin-right: 60px;
        background: alpha(@bg, 0.3);
        border-radius: 10px;
        color: lighter(@accent);
      }

      #clock {
        color: lighter(@accent);
        background: transparent;
      }

      #network {
        color: lighter(@accent);
        background: transparent;
      }

      #bluetooth {
        color: lighter(@accent);
        background: transparent;
      }

      #battery {
        color: lighter(@accent);
        background: transparent;
      }

      #memory {
        color: lighter(@accent);
        background: transparent;
      }

      #calendar {
        font-family: 'Ndot55, DepartureMono Nerd Font';
      }
    '';
  };
}
