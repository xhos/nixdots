{
  config,
  pkgs,
  lib,
  ...
}: let
  background =
    pkgs.fetchurl
    {
      url = "https://w.wallhaven.cc/full/x6/wallhaven-x6q9md.jpg";
      sha256 = "sha256-jBm+XKSCTWM99fbJIgOBiDNrow4DpfXMCawh8J67uVk=";
    };
in {
  stylix = {
    enable = true;

    base16Scheme =
      lib.mkIf (config ? theme && config.theme != null)
      "${pkgs.base16-schemes}/share/themes/${config.theme}.yaml";

    image = background;
    polarity = "dark";
    opacity.terminal = 0.6;

    cursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
    };

    targets = {
      zed.enable = false;
      firefox.enable = false;
      waybar.enable = false;
      spicetify.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
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
