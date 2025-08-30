{
  config,
  lib,
  ...
}: {
  xdg = {
    enable = true;

    cacheHome = config.home.homeDirectory + "/.cache";

    mimeApps = lib.mkIf (config.headless != true) {
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

    userDirs = lib.mkIf (config.headless != true) {
      enable = true;
      createDirectories = true;
    };
  };
}
