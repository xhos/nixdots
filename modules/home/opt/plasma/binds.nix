{
  lib,
  config,
  ...
}: {
  programs.plasma = lib.mkIf (config.default.de == "plasma") {
    shortcuts = {
      kwin = {
        # Window management binds remain the same
        "Kill Window" = "Meta+C";
        "Window Fullscreen" = "Meta+F";
        "Window Quick Tile Left" = "Meta+Left";
        "Window Quick Tile Right" = "Meta+Right";
        "Window Quick Tile Top" = "Meta+Up";
        "Window Quick Tile Bottom" = "Meta+Down";
        "Toggle Window Floating" = "Meta+D";
        "Window to Next Screen" = "Meta+Shift+Right";
        "Window to Previous Screen" = "Meta+Shift+Left";

        # Workspace navigation remains the same
        "Switch to Next Desktop" = "Meta+Alt+Down";
        "Switch to Previous Desktop" = "Meta+Alt+Up";
        "Window to Next Desktop" = "Meta+Alt+Shift+Down";
        "Window to Previous Desktop" = "Meta+Alt+Shift+Up";

        # Desktop switching remains the same
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";

        # Window moving remains the same
        "Window to Desktop 1" = "Meta+Shift+1";
        "Window to Desktop 2" = "Meta+Shift+2";
        "Window to Desktop 3" = "Meta+Shift+3";
        "Window to Desktop 4" = "Meta+Shift+4";
        "Window to Desktop 5" = "Meta+Shift+5";
        "Window to Desktop 6" = "Meta+Shift+6";
        "Window to Desktop 7" = "Meta+Shift+7";
        "Window to Desktop 8" = "Meta+Shift+8";
      };

      # System controls remain the same
      ksmserver = {
        "Lock Session" = ["Meta+L"];
      };

      # Screenshot remains the same
      spectacle = {
        "RectangularRegionScreenShot" = ["Meta+Shift+S"];
      };
    };

    # Additional hotkeys for custom commands
    hotkeys.commands = {
      "launch-rofi" = {
        name = "Launch Rofi";
        key = "Alt+Space";
        command = "rofi -show drun";
      };
    };
  };
}
