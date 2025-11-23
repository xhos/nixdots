{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.greeter == "regreet") {
    # Completely override the default command with portal blocking
    # services.greetd.settings.default_session.command = lib.mkForce (
    #   let
    #     greeterCmd = pkgs.writeShellScript "regreet-wrapper" ''
    #       export GTK_USE_PORTAL=0
    #       export GDK_DEBUG=no-portals
    #       exec ${pkgs.greetd.regreet}/bin/regreet
    #     '';
    #   in "${pkgs.dbus}/bin/dbus-run-session ${pkgs.cage}/bin/cage -s -- ${greeterCmd}"
    # );

    # # Disable xdg-portal for greeter user
    # systemd.user.services.xdg-desktop-portal.enable = lib.mkForce false;
    programs.regreet = {
      enable = true;
      cageArgs = ["-s" "-m" "last"];
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      theme = {
        name = "Materia-dark";
        package = pkgs.materia-theme;
      };
      font = {
        name = "Fira Sans";
        package = pkgs.fira;
        size = 12;
      };
      cursorTheme = {
        package = pkgs.apple-cursor;
        name = "macOS";
      };
    };
  };
}
