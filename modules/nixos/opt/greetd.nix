{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  config = lib.mkIf config.greetd.enable {
    programs.regreet = {
      enable = true;
      cageArgs = ["-s" "-m" "last"];
      theme = {
        package = pkgs.tokyonight-gtk-theme;
        name = "Tokyonight";
      };
      settings = {
        background = {
          path = "/etc/nixos/home/shared/walls/tokyo-night-storm.jpg";
          fit = "cover";
        };

        GTK = {
          application_prefer_dark_theme = true;
        };

        commands = {
          reboot = ["systemctl" "reboot"];
          poweroff = ["systemctl" "poweroff"];
        };
      };
    };

    services.greetd = {
      enable = true;
      # settings.default_session = {
      #   command = "${pkgs.cage}/bin/cage -s -m last -- ${config.programs.regreet.package}/bin/regreet";
      #   user = "greeter";
      # };
    };

    # Fixes broken text on tuigreet
    systemd.services.greetd = {
      serviceConfig.Type = "idle";
      unitConfig.After = ["docker.service"];
    };
  };
}
