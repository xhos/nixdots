{inputs, ...}: {
  imports = [inputs.logi-hypr.homeManagerModules.default];

  wayland.windowManager.hyprland.settings.exec-once = ["logi-hypr-run"];

  programs.logi-hypr = {
    enable = true;

    gesture.commands = {
      tap = "hyprctl dispatch togglespecialworkspace";
      left = "playerctl --player=spotify previous";
      right = "playerctl --player=spotify next";
      up = "hyprctl dispatch workspace m-1";
      down = "hyprctl dispatch workspace m+1";
    };

    scroll.rules = [
      {
        window = "Spotify";
        scrollRightCommands = [
          "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ];
        scrollLeftCommands = [
          "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ];
      }
      {
        window = "firefox|chrome|chromium|zen";
        scrollRightCommands = ["wtype -M ctrl -k Tab"];
        scrollLeftCommands = ["wtype -M ctrl -M shift -k Tab"];
      }
    ];
  };
}
