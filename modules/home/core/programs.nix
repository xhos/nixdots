{
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    bash.enable = true;
  };

  xdg.desktopEntries = {
    spotify = {
        name = "Spotify";
        genericName = "Spotify";
        exec = "spotify --enable-features=UseOzonePlatform --ozone-platform=wayland";
        terminal = false;
        categories = [ "Application" ];
    };
    chromium = {
        name = "Chromium";
        genericName = "Chromium";
        exec = "chromium --enable-features=UseOzonePlatform --ozone-platform=wayland";
        terminal = false;
        categories = [ "Application" ];
    };
  };
}
