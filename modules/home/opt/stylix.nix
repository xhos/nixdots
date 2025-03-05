{
  config,
  pkgs,
  lib,
  ...
}: let
  background =
    pkgs.fetchurl
    {
      url = "https://w.wallhaven.cc/full/p9/wallhaven-p9qmje.jpg";
      sha256 = "sha256-gWmdw8hLcAYQdvqjT2A5Rz0o3k+5H2qvfMxSN9Q9Z6A=";
    };
in {
  stylix = {
    enable = true;

    # base16Scheme =
    #   lib.mkIf (config ? theme && config.theme != null)
    #   "${pkgs.base16-schemes}/share/themes/${config.theme}.yaml";

    image = background;
    polarity = "dark";
    opacity.terminal = 0.6;

    cursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
    };

    iconTheme = {
      enable = true;
      package = pkgs.whitesur-icon-theme.override {
        alternativeIcons = true;
        boldPanelIcons = true;
      };
      dark = "WhiteSur-dark";
      light = "WhiteSur-light";
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
      kde.enable = false;
      gtk.extraCss = with config.lib.stylix.colors; ''
        @define-color accent_color #${base0D};
        @define-color accent_bg_color #${base0D};
        /* Mohammad Mahdi Tayebi
        *
        * To apply transparent sidebar. copy this file into ~/.config/gtk-4.0/gtk.css and if
        * you use adw-gtk3 theme you can add it to ~/.config/gtk-3.0/gtk.css as well
        *
        * Use blur my shell extension to add blur effect behind the transparent part of windows
        */

        /* Transparent Sidebar */
        window {
          background: alpha(@window_bg_color, 0.6);
        }

        .sidebar-pane,
        .sidebar,
        .navigation-sidebar {
          background: transparent;
        }

        .content-pane {
          background: @view_bg_color;
        }

        /* Lollypop */
        window>deck>grid>headerbar.titlebar>widget>widget>box>image {
          margin-top: -1px;
        }

        window>deck>grid>headerbar.titlebar>box> :nth-child(1) {
          margin-right: -40px;
          opacity: 0;
        }

        window>deck>grid>headerbar.titlebar>box> :nth-child(2) {
          margin-right: 27px;
        }

        window>deck>grid>headerbar.titlebar>box>.close {
          margin-right: 0;
        }

        window>deck>grid>headerbar.titlebar {
          background: linear-gradient(90deg,
              transparent 0%,
              transparent 197px,
              @headerbar_shade_color 198px,
              @headerbar_bg_color 198px,
              @headerbar_bg_color 100%);
          border-bottom: none;
        }

        /* Builder */
        .org-gnome-Builder paneldockchild.center {
          background: @window_bg_color;
        }

        .org-gnome-Builder.workspace paneldockchild.start {
          background: transparent;
        }

        /* Speedtest (xyz.ketok.Speedtest) */
        .horizontal>gauge.dl.horizontal>overlay>.background {
          background: transparent;
        }

        .horizontal>gauge.up.horizontal>overlay>.background {
          background: transparent;
        }

        /* Gnome Tweaks */
        window>leaflet>box:last-child>scrolledwindow>viewport.frame {
          background: @window_bg_color;
        }

        .tweak-titlebar-left {
          background: alpha(@window_bg_color, 0.6);
        }

        /* Geary */
        .geary-main-layout>leaflet>leaflet>box:first-child,
        .geary-main-layout>leaflet>leaflet>box:first-child>headerbar {
          background: transparent;
        }

        /* Rhythmbox */
        window box:nth-child(2) paned:nth-child(3) paned:nth-child(3) box:nth-child(2) {
          background: @window_bg_color;
        }

        window box:nth-child(2) paned:nth-child(3) box:first-child paned grid .sidebar-toolbar,
        window box:nth-child(2) paned:nth-child(3) box:first-child paned grid .sidebar-toolbar button {
          background: transparent;
        }

        window box toolbar {
          background: transparent;
          /* Comment this if you don't want transparency on rhythmbox topbar */
        }

        /* Disks */
        window>deck>box>leaflet>box:nth-child(3)>stack>statuspage>scrolledwindow>viewport.frame,
        window>deck>box>leaflet>box:nth-child(3)>stack>scrolledwindow>viewport.frame {
          background: @window_bg_color;
        }

        window>deck>box>leaflet>box:nth-child(1)>scrolledwindow treeview.view {
          background: transparent;
        }

        window>deck>box>leaflet>box:nth-child(1)>headerbar.titlebar.windowhandle {
          background: transparent;
          border-bottom: none;
        }
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
