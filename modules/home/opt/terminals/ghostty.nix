{
  lib,
  config,
  ...
}:
lib.mkIf (config.terminal == "ghostty") {
  home.sessionVariables.TERMINAL = "ghostty";

  programs.ghostty = {
    enable = true;
    settings = {
      # performance
      gtk-single-instance = true;
      quit-after-last-window-closed = true;
      quit-after-last-window-closed-delay = "5m";
      linux-cgroup = "never";

      # unbloat
      confirm-close-surface = false;
      link-previews = "osc8";
      resize-overlay = "never";

      # convenience
      mouse-scroll-multiplier = 3;
      focus-follows-mouse = true;
      term = "xterm-256color";

      # style
      bold-color = "bright";
      window-padding-x = 10;
      window-padding-y = 10;
    };
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # export env vars to DBus for XDG portals
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

      # start ghostty daemon in background
      "ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"
    ];

    bind = ["SUPER, Q, exec, ghostty --gtk-single-instance=true"];
  };
}
