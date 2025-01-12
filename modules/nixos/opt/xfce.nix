{
  config,
  lib,
  pkgs,
  ...
}: {
  # {
  #   services.xserver = lib.mkIf (config.de == "xfce") {
  #     enable = true;
  #     desktopManager = {
  #       xterm.enable = false;
  #       xfce.enable = true;
  #     };
  #   };

  #   services.displayManager.defaultSession = "xfce";

  config = lib.mkIf (config.de == "xfce") {
    environment = {
      systemPackages = with pkgs; [
        drawing # paint
        # elementary-xfce-icon-theme
        evince # doc viewer
        # foliate # ebook reader
        font-manager
        file-roller # archive manager
        gnome-disk-utility
        # libqalculate
        # libreoffice
        qalculate-gtk
        thunderbird
        wmctrl
        xclip
        xcolor
        xcolor
        xdo
        xdotool
        xfce.catfish
        xfce.gigolo
        xfce.orage
        xfce.xfburn
        xfce.xfce4-appfinder
        xfce.xfce4-clipman-plugin
        xfce.xfce4-cpugraph-plugin
        xfce.xfce4-dict
        xfce.xfce4-fsguard-plugin
        xfce.xfce4-genmon-plugin
        xfce.xfce4-netload-plugin
        xfce.xfce4-panel
        xfce.xfce4-pulseaudio-plugin
        xfce.xfce4-systemload-plugin
        xfce.xfce4-weather-plugin
        xfce.xfce4-whiskermenu-plugin
        xfce.xfce4-xkb-plugin
        xfce.xfdashboard
        xorg.xev
        xsel
        xtitle
        xwinmosaic
        zuki-themes
      ];
    };

    hardware = {
      bluetooth.enable = true;
    };

    programs = {
      dconf.enable = true;
      # gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-media-tags-plugin
          thunar-volman
        ];
      };
    };

    security.pam.services.gdm.enableGnomeKeyring = true;

    services = {
      # blueman.enable = true;
      # gnome.gnome-keyring.enable = true;
      # pipewire = {
      #   enable = true;
      #   alsa = {
      #     enable = true;
      #     support32Bit = true;
      #   };
      #   pulse.enable = true;
      # };
      xserver = {
        enable = true;
        excludePackages = with pkgs; [
          xterm
        ];
        displayManager = {
          lightdm = {
            enable = true;
            greeters.slick = {
              enable = true;
              theme.name = "Zukitre-dark";
            };
          };
        };
        desktopManager.xfce.enable = true;
      };
    };

    # sound.enable = true;
  };
}
