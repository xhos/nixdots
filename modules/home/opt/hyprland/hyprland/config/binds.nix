{
  config,
  pkgs,
  ...
}: let
  # Binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (x: let
      ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
    in [
      "SUPER, ${ws}, workspace, ${toString (x + 1)}"
      "SUPERSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
    ])
    10);

  # Get default application
  terminal = config.home.sessionVariables.TERMINAL;
in {
  wayland.windowManager.hyprland = {
    settings = {
      bind =
        [
          "SUPER, mouse_down, workspace, e-1"
          "SUPER, mouse_up, workspace, e+1"
          #TODO: binds to resize windows
          # Compositor commands
          "CTRLSHIFT, Q, exit"
          "SUPER, C, killactive"
          "SUPER, S, togglesplit"
          "SUPER, E, exec, nautilus"
          "SUPER, F, fullscreen"
          "SUPER, P, pseudo"
          "SUPERSHIFT, P, pin"
          "SUPER, D, togglefloating"

          # Grouped (tabbed) windows
          "SUPER, G, togglegroup"
          "SUPER, TAB, changegroupactive, f"
          "SUPERSHIFT, TAB, changegroupactive, b"

          # Cycle through windows
          "ALT, Tab, cyclenext"
          "ALT, Tab, bringactivetotop"
          "ALTSHIFT, Tab, cyclenext, prev"
          "ALTSHIFT, Tab, bringactivetotop"

          # Move focus
          # "SUPER, left, movefocus, l"
          # "SUPER, right, movefocus, r"
          # "SUPER, up, movefocus, u"
          # "SUPER, down, movefocus, d"

          # Move windows
          "SUPER, left, movewindow, l"
          "SUPER, right, movewindow, r"
          "SUPER, up, movewindow, u"
          "SUPER, down, movewindow, d"

          # Special workspaces
          "SUPERSHIFT, grave, movetoworkspace, special"
          "SUPER, grave, togglespecialworkspace"

          # Cycle through workspaces
          "SUPERALT, up, workspace, m-1"
          "SUPERALT, down, workspace, m+1"

          # Utilities
          "SUPER, Q, exec, ${terminal}"
          "SUPER, B, exec, ${config.default.browser}"
          "SUPER, L, exec, hyprlock"
          "SUPERSHIFT, T, exec, wl-ocr" # capture text

          # Resize windows
          "SUPERSHIFT, right, resizeactive, 200 0"
          "SUPERSHIFT, left, resizeactive, -200 0"
          "SUPERSHIFT, up, resizeactive, 0 -200"
          "SUPERSHIFT, down, resizeactive, 0 200"

          # Screenshot
          "SUPERSHIFT, S ,exec, hyprshot -m region --clipboard-only"
          "SUPER, V, exec, ${terminal} -a clipse clipse"

          ",Insert, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle" # mute microphone
        ]
        ++ workspaces;

      bindr = [
        # Launchers
        "ALT, code:65, exec, rofi -show drun"
        "SUPERSHIFT, p, exec, rofi-rbw --no-help --clipboarder wl-copy"
        "SUPERSHIFT, e, exec, bemoji"
      ];

      binde = [
        # Audio
        ",XF86AudioRaiseVolume, exec, volumectl up 5"
        ",XF86AudioLowerVolume, exec, volumectl down 5"
        ",XF86AudioMute, exec, volumectl toggle-mute"
        ",XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute"

        # Brightness
        ",XF86MonBrightnessUp, exec, lightctl up 5"
        ",XF86MonBrightnessDown, exec, lightctl down 5"
      ];

      # Mouse bindings
      bindm = ["SUPER, mouse:272, movewindow" "SUPER, mouse:273, resizewindow"];
    };

    # Configure submaps
    extraConfig = ''
      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset
    '';
  };
}
