{config, ...}: {
  services.swaync = {
    enable = true;

    style = ''
      @define-color foreground #${config.lib.stylix.colors.base05};
      @define-color background #${config.lib.stylix.colors.base00};
      @define-color color1     #${config.lib.stylix.colors.base01};
      @define-color color2     #${config.lib.stylix.colors.base08};
      @define-color color5     #${config.lib.stylix.colors.base0E};
      @define-color color6     #${config.lib.stylix.colors.base0D};
      @define-color color13    #${config.lib.stylix.colors.base0C};
      @define-color mpris-album-art-overlay #${config.lib.stylix.colors.base00};

      ${builtins.readFile ./notifications.css}
      ${builtins.readFile ./control-center.css}
    '';

    settings = {
      "$schema" = "/etc/xdg/swaync/configSchema.json";
      positionX = "right";
      positionY = "top";
      cssPriority = "application";
      layer = "overlay";
      "layer-shell" = true;

      "control-center-layer" = "top";
      "control-center-width" = 330;
      "control-center-height" = 725;
      "control-center-margin-top" = 2;
      "control-center-margin-bottom" = 2;
      "control-center-margin-right" = 1;
      "control-center-margin-left" = 0;

      "notification-window-width" = 400;
      "notification-window-height" = 200;
      "notification-icon-size" = 50;
      "notification-body-image-height" = 100;
      "notification-body-image-width" = 200;
      "notification-2fa-action" = true;
      "notifications-inline-replies" = true;

      timeout = 4;
      "timeout-low" = 4;
      "timeout-critical" = 4;

      "fit-to-screen" = false;
      "relative-timestamps" = true;
      "keyboard-shortcuts" = true;
      "image-visibility" = "when-available";
      "transition-time" = 200;
      "hide-on-clear" = false;
      "hide-on-action" = true;
      "script-fail-notify" = true;
      widgets = [
        "mpris"
        "title"
        "dnd"
        "notifications"
      ];

      "widget-config" = {
        title = {
          text = "NOTIFICATIONS";
          "clear-all-button" = true;
          "button-text" = "󰩺  CLEAR";
        };

        dnd = {
          text = "FUCK OFF";
        };

        mpris = {
          "image-size" = 76;
          "image-radius" = 10;
        };
      };
    };
  };
}
