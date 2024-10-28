{
  lib,
  pkgs,
  ...
}:
with lib; {
  config = {
    programs.waybar.settings.mainBar = {
      "group/connection" = {
        orientation = "inherit";
        modules = [
          "group/network"
        ];
      };

      "group/network" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          transition-left-to-right = true;
        };
        modules = ["network" "network#speed"];
      };

      network = {
        format = "{icon}";
        format-icons = {
          wifi = ["󰤨"];
          ethernet = ["󰈀"];
          disconnected = ["󰖪"];
        };
        format-wifi = "󰤨";
        format-ethernet = "󰈀";
        format-disconnected = "󰖪";
        format-linked = "󰈁";
        tooltip = false;
        on-click = "killall rofi || ${getExe pkgs.networkmanager_dmenu}";
      };

      "network#speed" = {
        format = " {bandwidthDownBits} ";
        rotate = 90;
        interval = 5;
        tooltip-format = "{ipaddr}";
        tooltip-format-wifi = ''
          {essid} ({signalStrength}%)   
          {ipaddr} | {frequency} MHz{icon} '';
        tooltip-format-ethernet = ''
          {ifname} 󰈀 
          {ipaddr} | {frequency} MHz{icon} '';
        tooltip-format-disconnected = "Not Connected to any type of Network";
        tooltip = true;
        on-click = "killall rofi || ${getExe pkgs.networkmanager_dmenu}";
      };
    };
  };
}
