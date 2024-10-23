{
  programs.waybar.settings.mainBar = {
    modules-left = ["hyprland/workspaces" "hyprland/submap"];

    "hyprland/submap" = {
      "format" = "<b>󰇘</b>";
      "max-length" = 8;
      "tooltip" = true;
    };

    "hyprland/workspaces" = {
      format = "{icon}";
      on-click = "activate";
      all-outputs = true;
      format-icons = {
        "1" = "一";
        "2" = "二";
        "3" = "三";
        "4" = "四";
        "5" = "五";
        "6" = "六";
        "7" = "七";
        "8" = "八";
        "9" = "九";
        "10" = "十";
      };
    };
  };
}
