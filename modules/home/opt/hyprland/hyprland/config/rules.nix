{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    # layer rules
    layerrule = let
      toRegex = list: let
        elements = lib.concatStringsSep "|" list;
      in "^(${elements})$";

      layers = [
        "gtk-layer-shell"
        "swaync-control-center"
        "swaync-notification-window"
        "waybar"
      ];
    in ["blur, ${toRegex layers}" "ignorealpha 0.5, ${toRegex layers}"];

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

      # Idk
      "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
      "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(firefox)$"
      "pin, title:^(Picture-in-Picture)$"
      # "workspace special silent, title:^(.*is sharing (your screen|a window).)$"
      # "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      # "workspace special, class:^(obsidian)$"
    ];
  };
}
