{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.steam.enable {
    # environment.systemPackages = with pkgs; [
    #   gamescope
    #   heroic
    #   lutris
    #   protontricks
    #   prismlauncher
    #   protonup-qt
    #   protonup
    # ];

    # nixpkgs.config.packageOverrides = pkgs: {
    #   steam = pkgs.steam.override {
    #     extraPkgs = pkgs:
    #       with pkgs; [
    #         keyutils
    #         libkrb5
    #         libpng
    #         libpulseaudio
    #         libvorbis
    #         protonup
    #         stdenv.cc.cc.lib
    #         xorg.libXcursor
    #         xorg.libXi
    #         xorg.libXinerama
    #         xorg.libXScrnSaver
    #       ];
    #   };
    # };

    programs = {
      steam = {
        enable = true;
        # remotePlay.openFirewall = true;
        # dedicatedServer.openFirewall = true;
        # gamescopeSession.enable = true;
        # package = pkgs.steam.override {
        #   extraPkgs = pkgs:
        #     with pkgs; [
        #       keyutils
        #       libkrb5
        #     ];
        # };
      };
      # gamemode.enable = true;
    };

    # environment.sessionVariables = lib.mkIf (config.de == "hyprland") {
    #   STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/xhos/.steam/root/.compatibilitytools.d";
    #   GDK_BACKEND = "wayland,x11";
    #   QT_QPA_PLATFORM = "wayland;xcb";
    #   #SDL_VIDEODRIVER = "x11";
    #   CLUTTER_BACKEND = "wayland";
    #   XDG_CURRENT_DESKTOP = "Hyprland";
    #   XDG_SESSION_TYPE = "wayland";
    #   XDG_SESSION_DESKTOP = "Hyprland";
    #   WLR_NO_HARDWARE_CURSORS = "1";
    # };
  };
}
