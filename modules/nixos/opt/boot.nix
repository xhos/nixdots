{ config, lib, inputs, pkgs, ... }: {
  config = lib.mkIf config.boot-management.enable {
    console = {
      enable = false;
      font = "Lat2-Terminus16";
      useXkbConfig = true; # Makes it so the tty console has about the same layout as the one configured in the services.xserver options.
    };

    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };

    services.displayManager.defaultSession = "Hyprland";
    services.greetd = lib.mkIf config.wayland.enable {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = let
          hyprland-session = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/share/wayland-sessions";
          base = config.services.displayManager.sessionData.desktops;
        in {
          command = "${lib.getExe pkgs.greetd.tuigreet} --time --remember --remember-session -- asterisks--sessions ${hyprland-session}";
          # command = lib.concatStringsSep " " [
          #   (lib.getExe pkgs.greetd.tuigreet)
          #   "--time"
          #   "--remember"
          #   "--remember-user-session"
          #   "--asterisks"
          #   "--sessions '${base}/share/wayland-sessions:${base}/share/xsessions'"
          # ];
          # user = "greeter";
        };
      };
    };

    systemd.services.greetd = {
      serviceConfig.Type = "idle"; # this fixes broken text on tuigreet
      unitConfig.After = [ "docker.service" ];
    };
  };
}
