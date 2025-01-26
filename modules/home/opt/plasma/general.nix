{
  lib,
  config,
  ...
}: {
  programs.plasma = lib.mkIf (config.default.de == "plasma") {
    enable = true;
    overrideConfig = true;
    #
    # Some high-level settings:
    #
    # workspace = {
    #   # clickItemTo = "open"; # If you liked the click-to-open default from plasma 5
    #   lookAndFeel = "org.kde.breezedark.desktop";
    #   cursor = {
    #     theme = "Bibata-Modern-Ice";
    #     size = 32;
    #   };
    #   iconTheme = "Papirus-Dark";
    #   wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Patak/contents/images/1080x1920.png";
    # };

    # hotkeys.commands."launch-konsole" = {
    #   name = "Launch Konsole";
    #   key = "Meta+Alt+K";
    #   command = "konsole";
    # };

    fonts = {
      general = {
        family = "Hack";
        pointSize = 12;
      };
    };

    # window-rules = [
    #   {
    #     description = "Dolphin";
    #     match = {
    #       window-class = {
    #         value = "dolphin";
    #         type = "substring";
    #       };
    #       window-types = ["normal"];
    #     };
    #     apply = {
    #       noborder = {
    #         value = true;
    #         apply = "force";
    #       };
    #       # `apply` defaults to "apply-initially"
    #       maximizehoriz = true;
    #       maximizevert = true;
    #     };
    #   }
    # ];

    # powerdevil = {
    #   AC = {
    #     powerButtonAction = "lockScreen";
    #     autoSuspend = {
    #       action = "shutDown";
    #       idleTimeout = 1000;
    #     };
    #     turnOffDisplay = {
    #       idleTimeout = 1000;
    #       idleTimeoutWhenLocked = "immediately";
    #     };
    #   };
    #   battery = {
    #     powerButtonAction = "sleep";
    #     whenSleepingEnter = "standbyThenHibernate";
    #   };
    #   lowBattery = {
    #     whenLaptopLidClosed = "hibernate";
    #   };
    # };

    # kwin = {
    #   edgeBarrier = 0; # Disables the edge-barriers introduced in plasma 6.1
    #   cornerBarrier = false;

    #   scripts.polonium.enable = true;
    # };

    # kscreenlocker = {
    #   lockOnResume = true;
    #   timeout = 10;
    # };

    #
    # Some mid-level settings:
    #

    #
    # Some low-level settings:
    #
    # configFile = {
    #   baloofilerc."Basic Settings"."Indexing-Enabled" = false;
    #   kwinrc."org.kde.kdecoration2".ButtonsOnLeft = "SF";
    #   kwinrc.Desktops.Number = {
    #     value = 8;
    #     # Forces kde to not change this value (even through the settings app).
    #     immutable = true;
    #   };
    #   kscreenlockerrc = {
    #     Greeter.WallpaperPlugin = "org.kde.potd";
    #     # To use nested groups use / as a separator. In the below example,
    #     # Provider will be added to [Greeter][Wallpaper][org.kde.potd][General].
    #     "Greeter/Wallpaper/org.kde.potd/General".Provider = "bing";
    #   };
    # };
  };
}
