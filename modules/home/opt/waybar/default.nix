{ pkgs, inputs, config, lib, ... }: {
  imports = [./style.nix];

  config = lib.mkIf (config.default.bar == "waybar") {
    programs.waybar = {
      enable = true;
      package = inputs.waybar.packages.${pkgs.system}.default;
      systemd.enable = true;
      systemd.target = "graphical-session.target";

      settings = [{
        battery = {
          format = "{icon}  {capacity}%";
          "format-alt" = "{icon} {time}";
          "format-charging" = "  {capacity}%";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
          "format-plugged" = " {capacity}% ";
          states = {
            critical = 15;
            good = 95;
            warning = 30;
          };
        };
        clock = {
          format = "{:%H:%M}";
          tooltip = "true";
          tooltip-format = "{:%B %d}";
        };
        cpu = {
          format = "󰻠 {usage}%";
          "format-alt" = "󰻠 {avg_frequency} GHz";
          interval = 5;
        };
        "custom/playerctl#backward" = {
          format = "󰙣 ";
          "on-click" = "playerctl previous";
          "on-scroll-down" = "playerctl volume .05-";
          "on-scroll-up" = "playerctl volume .05+";
        };
        "custom/playerctl#foward" = {
          format = "󰙡 ";
          "on-click" = "playerctl next";
          "on-scroll-down" = "playerctl volume .05-";
          "on-scroll-up" = "playerctl volume .05+";
        };
        "custom/playerctl#play" = {
          exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          format = "{icon}";
          "format-icons" = {
            Paused = "<span> </span>";
            Playing = "<span>󰏥 </span>";
            Stopped = "<span> </span>";
          };
          "on-click" = "playerctl play-pause";
          "on-scroll-down" = "playerctl volume .05-";
          "on-scroll-up" = "playerctl volume .05+";
          "return-type" = "json";
        };
        "custom/playerlabel" = {
          exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          format = "<span>󰎈 {} 󰎈</span>";
          "max-length" = 40;
          "on-click" = "";
          "return-type" = "json";
        };
        "custom/randwall" = {
          format = "󰏘";
        };
        height = 35;
        layer = "top";
        "margin-bottom" = 0;
        "margin-left" = 0;
        "margin-right" = 0;
        "margin-top" = 0;
        memory = {
          format = "󰍛 {}%";
          "format-alt" = "󰍛 {used}/{total} GiB";
          interval = 5;
        };
        "modules-center" = [
          "hyprland/workspaces"
        ];
        "modules-left" = [
          "custom/playerctl#backward"
          "custom/playerctl#play"
          "custom/playerctl#foward"
          "custom/playerlabel"
        ];
        "modules-right" = [
          "tray"
          "battery"
          "pulseaudio"
          "clock"
        ];
        position = "top";
        pulseaudio = {
          format = "{icon} {volume}%";
          "format-icons" = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          "format-muted" = "󰝟";
          "on-click" = "pavucontrol";
          "scroll-step" = 5;
        };
        tray = {
          "icon-size" = 20;
          spacing = 8;
        };
        "wlr/workspaces" = {
          "active-only" = false;
          "all-outputs" = false;
          "disable-scroll" = false;
          format = "{name}";
          "format-icons" = {
            active = "";
            default = "";
            "sort-by-number" = true;
            urgent = "";
          };
          "on-click" = "activate";
          "on-scroll-down" = "hyprctl dispatch workspace e+1";
          "on-scroll-up" = "hyprctl dispatch workspace e-1";
        };
      }];
    };
  };
}
