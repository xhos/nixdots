{config, ...}: let
  colors = ''
    @define-color background #${config.lib.stylix.colors.base00};
    @define-color foreground #${config.lib.stylix.colors.base0F};

    @define-color color0 #${config.lib.stylix.colors.base00};
    @define-color color1 #${config.lib.stylix.colors.base01};
    @define-color color2 #${config.lib.stylix.colors.base02};
    @define-color color3 #${config.lib.stylix.colors.base03};
    @define-color color4 #${config.lib.stylix.colors.base04};
    @define-color color5 #${config.lib.stylix.colors.base05};
    @define-color color6 #${config.lib.stylix.colors.base06};
    @define-color color7 #${config.lib.stylix.colors.base07};
    @define-color color8 #${config.lib.stylix.colors.base08};
    @define-color color9 #${config.lib.stylix.colors.base09};
    @define-color color10 #${config.lib.stylix.colors.base0A};
    @define-color color11 #${config.lib.stylix.colors.base0B};
    @define-color color12 #${config.lib.stylix.colors.base0C};
    @define-color color13 #${config.lib.stylix.colors.base0D};
    @define-color color14 #${config.lib.stylix.colors.base0E};
    @define-color color15 #${config.lib.stylix.colors.base0F};
    @define-color active #${config.lib.stylix.colors.base0D};
    @define-color inactive #${config.lib.stylix.colors.base03};
  '';
in {
  programs.waybar.style = ''
    ${colors}
    * {
      min-width: 15px;
      min-height: 0px;
    }

    window#waybar {
      transition-property: background-color;
      transition-duration: 0.5s;
      border-radius: 10px;
      border: 2px solid @inactive;
      background: alpha(@background, 0.6);
      color: @active;
    }

    menu,
    tooltip {
      border-radius: 10px;
      padding: 2px;
      border: 1px solid lighter(@inactive);
      background: alpha(@background, 0.6);
      color: lighter(@active);
    }

    menu label,
    tooltip label {
      font-size: 14px;
      color: lighter(@active);
    }

    #submap,
    #tray>.needs-attention {
      animation-name: blink-active;
      animation-duration: 1s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }

    .modules-right {
      margin: 0px 6px 6px 6px;
      border-radius: 4px;
      background: alpha(@background, 0.4);
      color: lighter(@active);
      padding: 2px 2px 4px 2px;
    }

    .modules-left {
      transition-property: background-color;
      transition-duration: 0.5s;
      margin: 10px 5px 10px 5px;
      border-radius: 10px;
      background: alpha(@background, 0.4);
      color: alpha(@foreground, 0.3);
    }

    #custom-notifications,
    #together,
    #submap,
    #connection,
    #cnoti,
    #power,
    #custom-updates,
    #custom-wl-gammarelay-temperature,
    #tray {
      margin: 3px 0px;
      border-radius: 4px;
      background: alpha(darker(@active), 0.3);
    }

    #audio {
      margin-top: 3px;
      padding: 6px 0px 6px 0px;
    }

    #brightness,
    #audio {
      border-radius: 4px;
      background: alpha(darker(@active), 0.3);
    }

    #custom-notifications {
      font-size: 14px;
      padding-right: 4px;
    }

    #custom-dmark {
      color: alpha(@foreground, 0.3);
    }

    #workspaces {
      margin: 0px 2px;
      padding: 4px 0px 0px 0px;
      border-radius: 8px;
    }

    #workspaces button {
      transition-property: background-color;
      transition-duration: 0.5s;
      color: @foreground;
      background: transparent;
      border-radius: 4px;
      color: alpha(@foreground, 0.3);
    }

    #workspaces button.urgent {
      font-weight: bold;
      color: @foreground;
    }

    #workspaces button.active {
      padding: 4px 2px;
      background: alpha(@active, 0.4);
      color: lighter(@active);
      border-radius: 4px;
    }

    #network.wifi {
      padding-right: 4px;
    }

    #submap {
      margin-bottom: 0px;
      min-width: 0px;
      margin: 4px 6px 4px 6px;
    }

    #battery {
      border-radius: 8px;
      padding: 4px 0px;
      margin: 4px 2px 4px 2px;
    }

    #battery.discharging.warning {
      animation-name: blink-yellow;
      animation-duration: 1s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }

    #battery.discharging.critical {
      animation-name: blink-red;
      animation-duration: 1s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }

    #clock {
      font-weight: bold;
      padding: 4px 2px 2px 2px;
    }

    #pulseaudio.mic {
      border-radius: 4px;
      color: @background;
      background: alpha(darker(@foreground), 0.6);
    }

    #backlight-slider slider,
    #pulseaudio-slider slider {
      background-color: transparent;
      box-shadow: none;
    }

    #backlight-slider trough,
    #pulseaudio-slider trough {
      margin-top: 4px;
      min-width: 6px;
      min-height: 60px;
      border-radius: 8px;
      background-color: alpha(@background, 0.6);
    }

    #backlight-slider highlight,
    #pulseaudio-slider highlight {
      border-radius: 8px;
      background-color: lighter(@active);
    }

    @keyframes blink-active {
      to {
        background-color: @active;
        color: @foreground;
      }
    }

    @keyframes blink-red {
      to {
        background-color: #c64d4f;
        color: @foreground;
      }
    }

    @keyframes blink-yellow {
      to {
        background-color: #cf9022;
        color: @foreground;
      }
    }
  '';
}
