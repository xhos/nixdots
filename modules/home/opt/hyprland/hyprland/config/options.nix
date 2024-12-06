{
  config,
  pkgs,
  ...
}: let
  wp =
    pkgs.lib.getExe
    (pkgs.callPackage ./wp-changer.nix {});
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # daemons
      "swww-daemon"
      "nm-applet"
      "blueman-applet"
      "clipse -listen"
      "xwaylandvideobridge"
      "wayvnc"
      "mako"
      "eval $(/run/wrappers/bin/gnome-keyring-daemon --start --daemonize)"

      # misc
      wp
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"

      # random fixes
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "dbus-update-activation-environment --systemd --all"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      # "systemctl --user import-environment PATH"
      # "systemctl --user restart xdg-desktop-portal.service"
      # "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1"
      # "ssh-add /home/xhos/.ssh/github"
      # ''echo "Xft.dpi: 130" | xrdb -merge''
      # "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 16c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 0.5"
    ];

    #-----------------------------------------------------------------------------------------------------------
    # GENERAL
    #-----------------------------------------------------------------------------------------------------------

    general = {
      gaps_in = "5";
      gaps_out = "10";
      border_size = "0";
      resize_on_border = "true";
      layout = "dwindle";

      "col.active_border" = "rgb(${config.lib.stylix.colors.base03})";
      "col.inactive_border" = "rgb(000000)";
    };

    #-----------------------------------------------------------------------------------------------------------
    # DECORATION
    #-----------------------------------------------------------------------------------------------------------

    decoration = {
      rounding = 10;

      shadow = {
        enabled = true;
        range = 15;
        render_power = 2;
        sharp = false;
        ignore_window = true;
        color = "rgb(${config.lib.stylix.colors.base03})";
        color_inactive = "rgb(000000)";
      };

      blur = {
        enabled = true;
        size = 12;
        passes = 4;
        new_optimizations = true;
        brightness = 1;
        contrast = "2";
      };

      layerrule = [
        "blur,RegularWindow"
        "blur,PopupWindow"
        "blur,notifications"
        "ignorezero,notifications"
      ];
    };

    #-----------------------------------------------------------------------------------------------------------
    # ANIMATIONS
    #-----------------------------------------------------------------------------------------------------------

    animations = {
      enabled = true;
      bezier = "quart, 0.25, 1, 0.5, 1";

      animation = [
        "windows, 1, 2, quart, slide"
        "border, 1, 2, quart"
        "borderangle, 1, 2, quart"
        "fade, 1, 2, quart"
        "workspaces, 1, 2, quart, slidevert"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
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
      # hyprgrass-bindm = ", longpress:2, movewindow";
      # hyprgrass-bind = ", edge:d:u, exec, sh /home/xhos/test.sh";
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
      vfr = true; # lower the amount of sent frames when nothing is happening on-screen
    };

    env = [
      # "GDK_SCALE,1"
      # "XCURSOR_SIZE,32"
      # "WLR_DRM_NO_ATOMIC,1"
      # "XDG_SESSION_TYPE,wayland"
      "GBM_BACKEND,nvidia-drm"
      "MOZ_ENABLE_WAYLAND=1"
      "MOZ_WEBRENDER=1"
      "MOZ_ACCELERATED=1"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "XDG_AUTO_SCREEN_SCALE_FACTOR=1"
      #  Mozilla settings to make FF and forks play nice with Wayland

      # Sign in New API Help About
      # My /usr/local/bin/sway-run file
      # 2.8 KB of Bash
      # Created 7 months, 2 weeks ago by Raine — expires in 134 days
      # Viewed 82 times
      # COPY TO CLIPBOARD SOFT WRAP RAW TEXT DUPLICATE DIFF

      # #!/bin/sh
      # # Environmental Settings for Sway
      # # To see if these variables are being set/used by SystemD  within the SystemD User Session
      # # run this as raine:  systemctl --user show-environment
      # # This is particularly necessary for certain apps to work correctly, IE the xdg-desktop-portal-wlr backend

      # # Session
      # export XDG_SESSION_TYPE=wayland
      # export XDG_SESSION_DESKTOP=sway
      # export XDG_CURRENT_DESKTOP=sway

      # ##
      # export XDG_AUTO_SCREEN_SCALE_FACTOR=1
      # export XDG_AUTO_SCREEN_SCALE_FACTOR=1

      # # Wayland stuff
      # # To force the usage of X11 on a Wayland session, use QT_QPA_PLATFORM=xcb.
      # # This might be necessary for some proprietary applications that do not use the system's
      # # implementation of Qt, such as zoom[AUR].
      # # The xcb option allows Qt to use the xcb (X11) plugin instead if Wayland is not available.
      # #export QT_QPA_PLATFORM=wayland;xcb

      # # export QT_WAYLAND_DISABLE_WINDOWDECORATION=0
      # export SDL_VIDEODRIVER=wayland
      # export QT_AUTO_SCREEN_SCALE_FACTOR=1
      # export QT_QPA_PLATFORMTHEME=qt5ct
      # export QT_QPA_PLATFORMTHEME=qt6ct

      # #  GTK: Use wayland if available, fall back to x11 if not.
      "GDK_BACKEND=wayland,x11"

      # # Clutter package already has wayland enabled,
      # # this variable will force Clutter applications to try and use the
      # # Wayland backend
      # export CLUTTER_BACKEND=wayland

      # # Force hardware video acceleration in Firefox
      # export MOZ_ENABLE_WAYLAND=1 firefox
      # export MOZ_ENABLE_WAYLAND=1 ghostery

      # # Java Specific Stuff
      # export _JAVA_AWT_WM_NONREPARENTING=1

      # # Inform Java clients of available TTF fonts directory
      # export JAVA_FONTS=/usr/share/fonts/TTF

      # # Set anti-aliasing in Java application's fonts, specifically Cgoban in my case t
      # export JDK_JAVA_OPTIONS=-Dawt.useSystemAAFontSettings=on,-Dswing.aatext=true

      # # Set the environment variable LD_BIND_NOW=1 for your games, to avoid needing to load program code at run time (see ld.so(8)), leading to a delay the first time a function is called.
      # # Do not set this for startplasma-x11 or other programs that link in libraries that do not actually exist on the system anymore and are never called by the program.
      # # If this is the case, the program fails on startup trying to link a nonexistent shared object, making this issue easily identifiable. Most games should start fine with this setting enabled.
      # export LD_BIND_NOW=1

      # # Video Acceleration
      # # You can override the driver for VDPAU by using the VDPAU_DRIVER environment variable.

      # # For Intel graphics you need to set it to va_gl
      # export VDPAU_DRIVER=va_gl

      # # Enable high definition video:
      # export LIBVA_DRIVER_NAME=iHD
    ];

    cursor.no_hardware_cursors = true;
    xwayland.force_zero_scaling = true;
  };
}
