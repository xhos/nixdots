{ inputs, pkgs, lib, config, ... }: {
  theme = "apathy";

  imports = [
    ../../modules/home
  ];

  xsession.scriptPath = ".hm-xsession";

  modules = {
    rofi.enable      = true;
    discord.enable   = true;
    spicetify.enable = true;
    firefox.enable   = true;
  };

  default = {
    de       = "hyprland";
    bar      = "waybar";
    lock     = "hyprlock";
    shell    = "fish";
    prompt   = "starship";
    terminal = "alacritty";
  };

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };

      gtk = {
        enable = true;
        theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome-themes-extra;
        };
      };

      # Wayland, X, etc. support for session vars
      # systemd.user.sessionVariables = config.home-manager.users.xhos.home.sessionVariables;

    qt = {
      enable = true;
      platformTheme = "gnome";
      style.name = "adwaita-dark";
    };
}
