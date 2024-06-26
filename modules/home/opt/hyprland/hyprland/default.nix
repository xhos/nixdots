{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  _ = lib.getExe;

  # OCR (Optical Character Recognition) utility
  ocrScript = let
    inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
  in
    pkgs.writeShellScriptBin "wl-ocr" ''
      ${_ grim} -g "$(${_ slurp})" -t ppm - | ${
        _ tesseract5
      } - - | ${wl-clipboard}/bin/wl-copy
      ${_ libnotify} "$(${wl-clipboard}/bin/wl-paste)"
    '';

  # Volume control utility
  volumectl = let
    inherit (pkgs) libnotify pamixer libcanberra-gtk3;
  in
    pkgs.writeShellScriptBin "volumectl" ''
      #!/usr/bin/env bash

      case "$1" in
      up)
        ${_ pamixer} -i "$2"
        ;;
      down)
        ${_ pamixer} -d "$2"
        ;;
      toggle-mute)
        ${_ pamixer} -t
        ;;
      esac

      volume_percentage="$(${_ pamixer} --get-volume)"
      isMuted="$(${_ pamixer} --get-mute)"

    '';

  # Brightness control utility
  lightctl = let
    inherit (pkgs) libnotify brightnessctl;
  in
    pkgs.writeShellScriptBin "lightctl" ''
      case "$1" in
      up)
        ${_ brightnessctl} -q s +"$2"%
        ;;
      down)
        ${_ brightnessctl} -q s "$2"%-
        ;;
      esac

      brightness_percentage=$((($(${_ brightnessctl} g) * 100) / $(${
        _ brightnessctl
      } m)))
    '';
in {
  imports = [
    ../hypridle
    ../hyprlock

    ./config
  ];

  config = lib.mkIf config.modules.hyprland.enable {
    home = {
      packages = with pkgs; [
        config.wayland.windowManager.hyprland.package

        autotiling-rs
        brightnessctl
        cliphist
        dbus
        glib
        grim
        gtk3
        hyprpicker
        libcanberra-gtk3
        libnotify
        pamixer
        sassc
        slurp
        wf-recorder
        wl-clipboard
        wl-screenrec
        wlr-randr
        wlr-randr
        wtype
        xwaylandvideobridge
        ydotool
        wlprop
        xorg.xprop

        ocrScript
        volumectl
        lightctl
      ];

      sessionVariables = {
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        XDG_SESSION_TYPE = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        QT_STYLE_OVERRIDE = "kvantum";
      };
    };

    wayland.windowManager.hyprland = {
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      
      plugins = [
        inputs.hyprgrass.packages.${pkgs.system}.default
        inputs.hyprspace.packages.${pkgs.system}.Hyprspace
      ];

      xwayland.enable = true;
      enable = true;
      systemd = {
        enable = true;
        extraCommands = lib.mkBefore [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };
    };

    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = ["graphical-session-pre.target"];
      };
    };

    xdg = {
      enable = true;
      mimeApps.enable = true;
      cacheHome = config.home.homeDirectory + "/.cache";
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
  };
}
