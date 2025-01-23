{
  pkgs,
  config,
  ...
}: {
  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
  };

  programs.ssh.addKeysToAgent = "yes";

  imports = [
    ./fonts
    ./nixpkgs.nix
    ./options.nix
    ./programs.nix
    ./home.nix
    ./zed.nix
  ];

  gtk = {
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {color = "nordic";};
    };
  };

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      associations.added = {
        "image" = ["swayimg.desktop"];
      };
      defaultApplications = {
        "x-scheme-handler/msteams" = ["teams-for-linux.desktop"];
        "image/jpeg" = ["swayimg.desktop"];
        "image/png" = ["swayimg.desktop"];
        "image/gif" = ["swayimg.desktop"];

        "text/html" = ["zen.desktop"];
        "text/xml" = ["zen.desktop"];
        "application/pdf" = ["zen.desktop"];
        "x-scheme-handler/http" = ["zen.desktop"];
        "x-scheme-handler/https" = ["zen.desktop"];
      };
    };

    cacheHome = config.home.homeDirectory + "/.cache";
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
  programs.home-manager.enable = true;
}
