{
  programs.waybar.settings.mainBar = {
    modules-right = ["group/together" "clock"];
    "group/together" = {
      orientation = "inherit";
      modules = [
        "group/utils"
        "group/connection"
        "custom/notifications"
        "group/brightness"
        "group/audio"
        "custom/hyprsunset"
        "hyprland/language"
      ];
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

    "custom/hyprsunset" = {
      format = '''';
      exec = "hyprsunset -t 6600";
      on-scroll-up = "hyprsunset -t 6600";
      on-scroll-down = "hyprsunset -t 2500";
    };

    "hyprland/language" = {
      format = "{}";
      format-en = "🦅";
      format-ru = "🐻";
      keyboard-name = "at-translated-set-2-keyboard";
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
        format = {today = "<span color='#a6e3a1'><b><u>{}</u></b></span>";};
      };
    };
  };
}
