{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  stylix = {
    enable = true;

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    base16Scheme = ./themes/${config.theme}.yaml;
    image = ../../../../home/shared/walls/${config.theme}.jpg;

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
      gtk.extraCss = with config.lib.stylix.colors; ''
        @define-color accent_color #${base0D};
        @define-color accent_bg_color #${base0D};
      '';
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCode Nerd Font Mono";
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
