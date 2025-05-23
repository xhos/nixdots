{
  pkgs,
  config,
  ...
}: {
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
