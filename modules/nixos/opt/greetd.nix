{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  config = lib.mkIf config.greetd.enable {
    # programs.regreet = {
    #   enable = true;
    #   cageArgs = ["-s" "-m" "last"];
    #   theme = {
    #     package = pkgs.tokyonight-gtk-theme;
    #     name = "Tokyonight";
    #   };
    #   settings = {
    #     background = {
    #       path = "/etc/nixos/home/shared/walls/tokyo-night-storm.jpg";
    #       fit = "cover";
    #     };

    #     GTK = {
    #       application_prefer_dark_theme = true;
    #     };

    #     commands = {
    #       reboot = ["systemctl" "reboot"];
    #       poweroff = ["systemctl" "poweroff"];
    #     };
    #   };
    # };
    programs.regreet = let
      background =
        pkgs.fetchurl
        {
          url = "https://w.wallhaven.cc/full/yx/wallhaven-yxpv7x.png";
          sha256 = "sha256-xRDTzoxCJC8yLKLKHQ8bZeojXP9ElQfXeviMQstMZl4=";
        };
    in {
      enable = true;
      cageArgs = ["-s" "-m" "last"];
      settings = {
        background = {
          path = background;
          fit = "Cover";
        };
        GTK = {
          application_prefer_dark_theme = true;
        };
      };
      theme = {
        package = pkgs.tokyonight-gtk-theme;
        name = "Tokyonight-Storm-BL-LB";
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme.override {color = "nordic";};
      };
      cursorTheme = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-dark";
      };
      font = {
        package = pkgs.hack-font;
        name = "Hack";
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
