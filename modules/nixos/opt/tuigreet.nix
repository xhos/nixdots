{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.greeter == "tuigreet") {
    services.greetd = {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = let
          hyprland-session = "${lib.getExe pkgs.hyprland}/share/wayland-sessions";
          # hyprland-session = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/share/wayland-sessions";
        in {
          command = "${lib.getExe pkgs.greetd.tuigreet} --time --remember --remember-session -- asterisks--sessions ${hyprland-session}";
        };
      };
    };

    # Fixes broken text on tuigreet
    systemd.services.greetd = {
      serviceConfig.Type = "idle";
      unitConfig.After = ["docker.service"];
    };
  };
}
