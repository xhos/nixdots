{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    # layer rules
    layerrule = let
      toRegex = list: let
        elements = lib.concatStringsSep "|" list;
      in "^(${elements})$";
      layers = [
        "gtk4-layer-shell"
        "rofi"
      ];
    in [
      "blur, ${toRegex layers}"
    ];

    # window rules
    windowrulev2 = [
      # XWayland screen sharing related
      "opacity 0.0 override, class:^(xwaylandvideobridge)$"
      "noanim, class:^(xwaylandvideobridge)$"
      "noinitialfocus, class:^(xwaylandvideobridge)$"
      "maxsize 1 1, class:^(xwaylandvideobridge)$"
      "noblur, class:^(xwaylandvideobridge)$"

      # Dim around
      "dimaround, class:^(gcr-prompter)$"
      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, class:^(polkit-gnome-authentication-agent-1)$"

      # Float
      "float, class:^(pavucontrol)$"
      "size 622 652,class:(pavucontrol)"
      "float, class:^(blueman-manager)$"
      "size 622 652,class:(blueman-manager)"
      "float, class:^(nm-connection-editor)$"
      "float, class:^(xdg-desktop-portal-gtk)$"
      "float, title:^(Media viewer)$"
      "float, title:^(Picture-in-Picture)$"
      "float,class:(clipse)"
      "size 622 652,class:(clipse)"

      "float,class:(bluetui)"
      "size 622 652,class:(bluetui)"

      "float,class:(impala)"
      "size 622 652,class:(impala)"

      "float,class:(pulsemixer)"
      "size 622 652,class:(pulsemixer)"

      "tile, class:(web-app)" # for web apps to tile properly

      # Idk
      "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
      "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(firefox)$"
      "pin, title:^(Picture-in-Picture)$"
      # "workspace special silent, title:^(.*is sharing (your screen|a window).)$"
      # "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      # "workspace special, class:^(obsidian)$"
      "opacity 0.99, class:^(obsidian)$"
    ];

    # workspace = [
    #   "w[tv1]s[false], gapsout:0, gapsin:0"
    #   "f[1]s[false], gapsout:0, gapsin:0"
    # ];
    # windowrule = [
    #   "bordersize 0, floating:0, onworkspace:w[tv1]s[false]"
    #   "rounding 0, floating:0, onworkspace:w[tv1]s[false]"
    #   "bordersize 0, floating:0, onworkspace:f[1]s[false]"
    #   "rounding 0, floating:0, onworkspace:f[1]s[false]"
    # ];
  };
}
