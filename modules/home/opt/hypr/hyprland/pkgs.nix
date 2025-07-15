{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.default.de == "hyprland") {
    home.packages = with pkgs; [
      # TUI control tools
      pulsemixer # audio mixer
      bluetui # bluetooth manager
      impala # network manager

      bemoji # emoji picker
      clipse # clipboard manager
      swww

      wvkbd

      # TODO: this.
      autotiling-rs
      brightnessctl
      cliphist
      dbus
      glib
      grim
      gtk3
      hyprpicker
      libcanberra-gtk3
      pamixer
      sassc
      slurp
      wf-recorder
      wl-clipboard
      wl-screenrec
      wlr-randr
      wlr-randr
      wtype
      ydotool
      wlprop
      xorg.xprop
    ];
  };
}
