{ pkgs, inputs, config, lib, ... }: {
  imports = [./style.nix];

  config = lib.mkIf (config.default.bar == "waybar") {
    programs.waybar = {
      enable = true;
      package = inputs.waybar.packages.${pkgs.system}.default;
      systemd.enable = true;
      systemd.target = "graphical-session.target";

      settings = [{
        position = "bottom"; # Waybar position (top|bottom|left|right)
        height = 5; # Waybar height (to be removed for auto height)
      
        # Choose the order of the modules
        modules-left = ["sway/workspaces" "sway/mode" "custom/media"];
        modules-center = ["sway/window"];
        modules-right = ["pulseaudio" "network" "backlight" "cpu" "memory" "battery" "battery#bat2" "clock" "tray"];
      
        # Modules configuration
        sway = {
          mode = {
            format = "<span style=\"italic\">{}</span>";
          };
        };
      
        mpd = {
          format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ ";
          format-disconnected = "Disconnected ";
          format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          unknown-tag = "N/A";
          interval = 2;
          consume-icons = {
            on = " ";
          };
          random-icons = {
            off = "<span color=\"#f53c3c\"></span> ";
            on = " ";
          };
          repeat-icons = {
            on = " ";
          };
          single-icons = {
            on = "1 ";
          };
          state-icons = {
            paused = "";
            playing = "";
          };
          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };
      
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
      
        tray = {
          spacing = 10;
        };
      
        clock = {
          format = "{:%I:%M }";
          format-alt = "{:%Y-%m-%d}";
        };
      
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
      
        memory = {
          format = "{}% ";
        };
      
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };
      
        backlight = {
          format = "{percent}% ";
          format-icons = ["" ""];
        };
      
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% ";
          format-charging = "{capacity}%";
          format-plugged = "{capacity}%";
          format-alt = "{time} ";
        };
      
        "battery#bat2" = {
          bat = "BAT2";
        };
      
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
      
        pulseaudio = {
          format = "{volume}%  {format_source}";
          format-bluetooth = "{volume}%  {format_source}";
          format-bluetooth-muted = " {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          on-click = "pavucontrol";
        };
      
        "custom/media" = {
          format = " {}";
          return-type = "json";
          max-length = 40;
          escape = true;
          exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
        };
      }];
    };
  };
}
