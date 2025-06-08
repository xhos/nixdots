{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  config = lib.mkIf (config.default.bar == "quickshell") {
    qt.enable = true;
    home.packages = with pkgs; let
      qsBase = inputs.quickshell.packages.${pkgs.system}.default.override {
        withJemalloc = true;
        withQtSvg = true;
        withWayland = true;
        withX11 = false;
        withPipewire = true;
        withPam = true;
        withHyprland = true;
        withI3 = false;
      };
    in [
      # add Qt5Compat to the *build* so it’s wrapped automatically
      (qsBase.overrideAttrs (old: {
        buildInputs =
          old.buildInputs
          ++ [
            pkgs.qt6.qt5compat
            pkgs.python312Packages.pyaudio
            pkgs.python312Packages.numpy
            pkgs.python3
          ];
      }))
      # Essential Qt runtime components for quickshell and its themes
      qt6.qtwayland
      qt6.qt5compat # For Qt5Compat.GraphicalEffects and other compat QML modules

      # General runtime dependencies for quickshell based on BUILD.MD and enabled features
      cli11 # Base dependency for quickshell
      wayland # For Wayland support
      wayland-protocols # For Wayland support
      libdrm # For Screencopy feature (often enabled with Wayland)
      libgbm # For Screencopy feature (often enabled with Wayland)
      # google-breakpad # Optional: for crash reporter feature (enabled by default in quickshell)

      # User requested packages
      git
      curl
      jq
      # app2unit-git # Placeholder: find equivalent Nix package or add via overlay
      fd
      fish
      python312Packages.pyaudio
      python312Packages.numpy
      cava
      networkmanager # Provides CLI tools, for GUI use networkmanagerapplet
      bluez # Provides bluez-utils
      brightnessctl
      ddcutil # monitor control (already present)

      # Existing Caelestia helpers & theming
      python3
      python311Packages.aubio # python-aubio
      papirus-icon-theme # or breeze-icons
      hicolor-icon-theme # fallback skeleton
      qt6ct # GUI to pick icons/colours
    ];
    # fonts.packages = with pkgs; [ibm-plex nerd-fonts.jetbrains-mono];
    home.sessionVariables = let
      papirus = pkgs.papirus-icon-theme;
      hicolor = pkgs.hicolor-icon-theme;
    in {
      QT_ICON_THEME = "Papirus"; # force the name Qt should load
      QT_QPA_PLATFORMTHEME = "qt6ct"; # so Qt obeys the user icon theme
      # Pre-pend the *parent* dir – Qt automatically appends “/icons”
      XDG_DATA_DIRS =
        "${papirus}/share:${hicolor}/share"
        + ":${builtins.getEnv "XDG_DATA_DIRS"}";
    };
  };
}
