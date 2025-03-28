{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.de == "gnome") {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
    };

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      ghostty
      gnomeExtensions.valent

      # needed for proper screenshot experience
      # bash -c 'gnome-screenshot -a --file=/tmp/foo.png && xclip -selection clipboard -t image/png -i /tmp/foo.png'
      gnome-screenshot
      xclip
    ];

    programs.kdeconnect = {
      enable = true;
      package = pkgs.valent;
    };

    services.displayManager.defaultSession = "gnome";
  };
}
