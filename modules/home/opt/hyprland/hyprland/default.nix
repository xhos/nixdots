{ config, inputs, lib, pkgs, ... }:
let
  # OCR (Optical Character Recognition) utility
  ocrScript = let
    inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
  in
    pkgs.writeShellScriptBin "wl-ocr" ''
      ${lib.getExe grim} -g "$(${lib.getExe slurp})" -t ppm - | ${
      lib.getExe tesseract5
      } - - | ${wl-clipboard}/bin/wl-copy
      ${lib.getExe libnotify} "$(${wl-clipboard}/bin/wl-paste)"
    '';

  # Volume control utility
  volumectl = let
    inherit (pkgs) libnotify pamixer libcanberra-gtk3;
  in
    pkgs.writeShellScriptBin "volumectl" ''
      #!/usr/bin/env bash

      case "$1" in
      up)
        ${lib.getExe pamixer} -i "$2"
        ;;
      down)
        ${lib.getExe pamixer} -d "$2"
        ;;
      toggle-mute)
        ${lib.getExe pamixer} -t
        ;;
      esac

      volumelib.getExepercentage="$(${lib.getExe pamixer} --get-volume)"
      isMuted="$(${lib.getExe pamixer} --get-mute)"

    '';

  # Brightness control utility
  lightctl = let
    inherit (pkgs) libnotify brightnessctl;
  in
    pkgs.writeShellScriptBin "lightctl" ''
      case "$1" in
      up)
        ${lib.getExe brightnessctl} -q s +"$2"%
        ;;
      down)
        ${lib.getExe brightnessctl} -q s "$2"%-
        ;;
      esac

      brightnesslib.getExepercentage=$((($(${lib.getExe brightnessctl} g) * 100) / $(${
        lib.getExe brightnessctl
      } m)))
    '';
in {
  imports = [
    ../hypridle
    ../hyprlock

    ./config
  ];

  config = lib.mkIf (config.default.de == "hyprland") {
    home = {
      packages = with pkgs; [
        config.wayland.windowManager.hyprland.package
        wl-gammarelay-rs # display temp
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
        # xwaylandvideobridge
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
      };
    };

    wayland.windowManager.hyprland = {
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;

      plugins = [
        inputs.hyprgrass.packages.${pkgs.system}.default
        # inputs.hyprscroller.packages.${pkgs.system}.default
        # inputs.hyprspace.packages.${pkgs.system}.Hyprspace
      ];

      # xwayland.enable = true;
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
