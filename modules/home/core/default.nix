{config, ...}: {
  # home.sessionVariables = {
  #   SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
  # };

  imports = [
    ./fonts
    ./home.nix
    ./nixpkgs.nix
    ./options.nix
    ./programs.nix
    ./ssh.nix
    ./zed.nix
  ];

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      associations.added = {
        "image" = ["swayimg.desktop"];
        "x-scheme-handler/http" = ["zen-beta.desktop"];
        "x-scheme-handler/https" = ["zen-beta.desktop"];
        "x-scheme-handler/chrome" = ["zen-beta.desktop"];
        "text/html" = ["zen-beta.desktop"];
        "application/x-extension-htm" = ["zen-beta.desktop"];
        "application/x-extension-html" = ["zen-beta.desktop"];
        "application/x-extension-shtml" = ["zen-beta.desktop"];
        "application/xhtml+xml" = ["zen-beta.desktop"];
        "application/x-extension-xhtml" = ["zen-beta.desktop"];
        "application/x-extension-xht" = ["zen-beta.desktop"];
      };
      defaultApplications = {
        "x-scheme-handler/msteams" = ["teams-for-linux.desktop"];
        "image/jpeg" = ["swayimg.desktop"];
        "image/png" = ["swayimg.desktop"];
        "image/gif" = ["swayimg.desktop"];

        "text/html" = ["zen-beta.desktop"];
        "text/xml" = ["zen.desktop"];
        "application/pdf" = ["zen.desktop"];
        "x-scheme-handler/http" = ["zen-beta.desktop"];
        "x-scheme-handler/https" = ["zen-beta.desktop"];
        "x-scheme-handler/chrome" = ["zen-beta.desktop"];
        "application/x-extension-htm" = ["zen-beta.desktop"];
        "application/x-extension-html" = ["zen-beta.desktop"];
        "application/x-extension-shtml" = ["zen-beta.desktop"];
        "application/xhtml+xml" = ["zen-beta.desktop"];
        "application/x-extension-xhtml" = ["zen-beta.desktop"];
        "application/x-extension-xht" = ["zen-beta.desktop"];
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
