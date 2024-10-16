{ config, pkgs, ... }:
let
    wvkbd-toggle = let
      inherit (pkgs) wvkbd;
    in
      pkgs.writeShellScriptBin "wvkbd" ''
        if pgrep -x "wvkbd-mobintl" > /dev/null; then
            pkill -x "wvkbd-mobintl"
        else
            wvkbd-mobintl -L 200 &
        fi
      '';

    setWallpaper = "swww img ${config.wallpaper}";
  in { wayland.windowManager.hyprland.settings = {
    exec-once = [
      "swww-daemon"
      "nm-applet"
      "blueman-applet"
      "clipse -listen"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user import-environment PATH"
      "systemctl --user restart xdg-desktop-portal.service"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1"
      "eval $(/run/wrappers/bin/gnome-keyring-daemon --start --daemonize)"
      "ssh-add /home/xhos/.ssh/github"
      "protonvpn-app"
      "wayvnc"
      setWallpaper
    ];

    animations = {
      enabled = true;
      bezier = ["md3_decel, 0.05, 0.7, 0.1, 1"];

      animation = [
        "border, 1, 2, default"
        "fade, 1, 2, md3_decel"
        "windows, 1, 4, md3_decel, popin 60%"
        "workspaces, 1, 4, md3_decel, slidevert"
      ];
    };

    decoration = {
      # "col.shadow" = "rgb(${config.w})";
      # "col.shadow_inactive" = "rgba(${config.accent}00)";
      inactive_opacity = "0.94";
      drop_shadow = "true";
      rounding = 10;
      shadow_ignore_window = "true";
      shadow_range = 16;
      shadow_render_power = 2;

      blurls = [
        "RegularWindow"
        "PopupWindow"
      ];

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
      # no_gaps_when_only = -1;
    };

    general = {
      gaps_in = "8";
      gaps_out = "12";
      border_size = "0";
      layout = "dwindle";
      resize_on_border = "true";
      # "col.active_border" = "rgba(${config.accent}88)";
      # "col.inactive_border" = "rgba(${config.background}88)";

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
      workspace_swipe_edge = "";
      hyprgrass-bindm = ", longpress:2, movewindow";
      hyprgrass-bind = ", edge:d:u, exec, sh /home/xhos/test.sh";
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
      swallow_regex = config.default.terminal; # windows for which swallow is applied
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      focus_on_activate = true; # whether Hyprland should focus an app that requests to be focused (an activate request)
      force_default_wallpaper = 0;
      key_press_enables_dpms = true;
      mouse_move_enables_dpms = true; # if DPMS is set to off, wake up the monitors if the mouse moves
      vfr = true;                     # lower the amount of sent frames when nothing is happening on-screen
    };

    monitor = [
      "eDP-1,1920x1080@60.0,1615x1685,1.0"
      "DP-1,1920x1080@120.0,1350x335,0.8"
      "DP-2,1920x1080@120.0,0x0,0.8"
      "DP-2,transform,1"
    ];

    workspace= [
      "1,monitor:eDP-1,default:true"
      "2,monitor:DP-1,default:true"
      "3,monitor:DP-2,default:true"
    ];

    env = [
      "GDK_SCALE,2"
      "XCURSOR_SIZE,32"
      # "WLR_DRM_NO_ATOMIC,1"
      "XDG_SESSION_TYPE,wayland"
      "GBM_BACKEND,nvidia-drm"
    ];

    cursor.no_hardware_cursors = true;
    xwayland.force_zero_scaling = true;
  };
}
