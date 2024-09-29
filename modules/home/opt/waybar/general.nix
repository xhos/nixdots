{ pkgs, lib, ... }: {
  programs.waybar.settings.mainBar = {
    modules-right = [ "group/together" ];
    "group/together" = {
      orientation = "inherit";
      modules = [ "group/utils" "clock" ];
    };
    "group/utils" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = true;
      };
      modules = [
        "custom/mark"
        "tray"
      ];
    };
    tray = {
      icon-size = 18;
      spacing = 10;
    };
    "custom/mark" = {
      format = "";
      tooltip = false;
    };
    clock = {
      format = ''
        {:%H
        %M}'';
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "month";
        mode-mon-col = 3;
        weeks-pos = "right";
        on-scroll = 1;
        on-click-right = "mode";
        format = { today = "<span color='#a6e3a1'><b><u>{}</u></b></span>"; };
      };
    };
  };
}
