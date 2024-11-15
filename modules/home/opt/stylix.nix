{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.theme}.yaml";
    image = ../../../home/shared/walls/tokyo-night-dark.jpg;
    polarity = "dark";
    opacity.terminal = 0.6;

    cursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 10;
    };

    targets = {
      firefox.enable = false;
      waybar.enable = false;
      spicetify.enable = false;
      hyprland.enable = false;
      mako.enable = false;
      rofi.enable = false;
      gtk.extraCss = with config.lib.stylix.colors; ''
        @define-color accent_color #${base0D};
        @define-color accent_bg_color #${base0D};
      '';
    };

    fonts = {
      monospace = {
        package = pkgs.hack-font;
        name = "Hack";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };
  };
}
