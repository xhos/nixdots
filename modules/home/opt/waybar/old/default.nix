{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  imports = [./style.nix];

  config = lib.mkIf (config.default.bar == "waybar") {
    programs.waybar = {
      enable = true;
      package = inputs.waybar.packages.${pkgs.system}.default;
      systemd.enable = true;
      systemd.target = "graphical-session.target";

      settings = [
        {
          position = "top"; # Waybar position (top|bottom|left|right)
          height = 8; # Waybar height (to be removed for auto height)

          modules-left = ["hyprland/workspaces" "hyprland/submap" "custom/spotify"];
          modules-center = ["clock"];
          modules-right = ["tray" "hyprland/language" "pulseaudio" "network" "battery"];

          # Modules configuration
          # TODO: go to spotify on click
          "custom/spotify" = {
            interval = 1;
            return-type = "json";
            exec = "sh /home/xhos/spotify.sh";
            exec-if = "pgrep spotify";
            escape = "true";
          };

          "hyprland/language" = {
            format = "{}";
            format-en = "🦅";
            format-ru = "🐻";
            keyboard-name = "at-translated-set-2-keyboard";
          };

          "hyprland/workspaces".active-only = true;

          tray = {
            spacing = 10;
          };

          clock = {
            format = "{:%H:%M }";
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
            format-charging = "󱐋 {capacity}%";
            format-plugged = "{capacity}%";
            format-alt = "{time} ";
          };

          network = {
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };

          pulseaudio = {
            format = "{icon}  {volume:2}%";
            format-bluetooth = "{icon}  {volume}%";
            format-muted = "";
            format-icons = {
              headphones = "";
              default = ["" ""];
              scroll-step = 1;
              on-click = "pamixer -t";
              on-click-right = "pavucontrol";
            };
          };
        }
      ];
    };
  };
}
