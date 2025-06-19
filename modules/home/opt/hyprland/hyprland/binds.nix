{
  config,
  pkgs,
  ...
}: let
  # Binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (x: let
      ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
    in [
      "SUPER, ${ws}, split:workspace, ${toString (x + 1)}"
      "SUPERSHIFT, ${ws}, split:movetoworkspace, ${toString (x + 1)}"
    ])
    10);

  terminal = config.home.sessionVariables.TERMINAL;
in {
  wayland.windowManager.hyprland.settings = {
    # https://wiki.hyprland.org/Configuring/Binds/#bind-flags
    bind =
      [
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

        # Move windows
        "SUPER, left, movewindow, l"
        "SUPER, right, movewindow, r"
        "SUPER, up, movewindow, u"
        "SUPER, down, movewindow, d"

        # Resize windows
        "SUPERSHIFT, right, resizeactive, 200 0"
        "SUPERSHIFT, left, resizeactive, -200 0"
        "SUPERSHIFT, up, resizeactive, 0 -200"
        "SUPERSHIFT, down, resizeactive, 0 200"

        # Special workspaces
        "SUPERSHIFT, grave, movetoworkspace, special"
        "SUPER, grave, togglespecialworkspace"

        # Cycle through workspaces
        "SUPERALT, up, split:workspace, m-1"
        "SUPERALT, down, split:workspace, m+1"
        "SUPER, mouse_down, split:workspace, e-1"
        "SUPER, mouse_up, split:workspace, e+1"

        # swap all windows between monitors
        "SUPERSHIFT, G, split:swapactiveworkspaces, current +1"
        # bring any “rogue” windows back to this ws
        "SUPERSHIFT, R, split:grabroguewindows"

        # Utilities
        "SUPER, Q, exec, ${terminal}" # open terminal
        "SUPER, B, exec, ${config.default.browser}" # open browser
        "SUPER, L, exec, hyprlock" # lock screen
        # "SUPERSHIFT, T, exec, wl-ocr" # capture text TODO: find a better way to do this
        "SUPERSHIFT, S ,exec, hyprshot -m region --clipboard-only" # screenshot
        "SUPER, V, exec, ${terminal} -a clipse clipse" # clipboard manager
        "SUPERSHIFT, B, exec, ${terminal} -a bluetui bluetui" # bluetooth manager
        "SUPERSHIFT, N, exec, ${terminal} -a impala impala" # network manager
        "SUPERSHIFT, A, exec, ${terminal} -a pulsemixer pulsemixer" # network manager
        "SUPERSHIFT, e, exec, bemoji" # emoji picker
        ",insert, exec, ${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute" # toggle mic mute
        # "ALT, code:65, exec, rofi -show drun" # rofi drun
      ]
      ++ workspaces;

    # will repeat while held
    binde = [
      # Audio
      ",XF86AudioRaiseVolume, exec, volumectl up 5"
      ",XF86AudioLowerVolume, exec, volumectl down 5"
      ",XF86AudioMute, exec, volumectl toggle-mute"

      # Brightness
      ",XF86MonBrightnessUp, exec, lightctl up 5"
      ",XF86MonBrightnessDown, exec, lightctl down 5"
    ];

    # mouse bindings
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}
