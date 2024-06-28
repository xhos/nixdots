{ config, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "ags"
      "nm-applet"
      "blueman-applet"
      "clipse -listen"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user import-environment PATH"
      "systemctl --user restart xdg-desktop-portal.service"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1"
      "protonvpn-app" # TODO: find another way to do this
    ];
    animations = {
      enabled = true;

      bezier = ["md3_decel, 0.05, 0.7, 0.1, 1"];

      animation = [
        "border, 1, 2, default"
        "fade, 1, 2, md3_decel"
        "windows, 1, 4, md3_decel, popin 60%"
        # "workspaces, 1, 4, md3_decel, slidevert" # i rather have horizontal switch
      ];
    };

    decoration = {
      "col.shadow" = "rgb(${config.background})";
      "col.shadow_inactive" = "rgba(${config.background}00)";
      inactive_opacity = "0.94";
      drop_shadow = "true";
      rounding = 10;
      shadow_ignore_window = "true";
      shadow_range = 16;
      shadow_render_power = 2;

      blur = {
        brightness = 1;
        contrast = "1.200000";
        enabled = "yes";
        ignore_opacity = "on";
        new_optimizations = "on";
        noise = "0.011700";
        passes = 3;
        size = 6;
        xray = "false";
      };
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    env = ["GDK_SCALE,2" "WLR_DRM_NO_ATOMIC,1"];

    general = {
      gaps_in = "8";
      gaps_out = "12";
      border_size = "0";
      layout = "dwindle";
      resize_on_border = "true";
      "col.active_border" = "rgba(${config.accent}88)";
      "col.inactive_border" = "rgba(${config.background}88)";

      allow_tearing = true;
    };

    device = {
      name = "znt0001:00-14e5:650e-touchpad";
      sensitivity = "+0.2";
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_cancel_ratio = 0.01;
      workspace_swipe_forever = true;
    };

    "plugin:touch_gestures" = {
      sensitivity = 5.0;
    };

    group = {
      groupbar = {
        font_size = 16;
        gradients = false;
      };
    };

    input = {
      kb_layout = "us, ru";
      kb_options = "grp:alt_shift_toggle";

      accel_profile = "adaptive";
      follow_mouse = 1;

      touchpad = {
        disable_while_typing = true;
        natural_scroll = true;
        scroll_factor = 0.5;
      };
    };

    misc = {
      enable_swallow = true; # hide windows that spawn other windows
      swallow_regex = "wezterm"; # windows for which swallow is applied
      disable_autoreload = false;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      focus_on_activate = true;
      force_default_wallpaper = 0;
      key_press_enables_dpms = true;
      mouse_move_enables_dpms = true;
      no_direct_scanout = false;
      vfr = true;
      vrr = 1;
    };

    monitor = [
      # name, resolution, position, scale
      "eDP-1, highres, 0x0, 1"
    ];

    xwayland.force_zero_scaling = true;
  };
}
