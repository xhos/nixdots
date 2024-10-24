{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.mako = {
    # Enables a simple notification daemon
    enable = true;
    anchor = "top-right";
    backgroundColor = "#282a36";
    borderColor = "#bd93f9";
    borderSize = 3;
    defaultTimeout = 3000;
    font = "Mononoki Nerd Font Mono 10";
    height = 150;
    width = 300;
    icons = true;
    textColor = "#f8f8f2";
    layer = "overlay";
    sort = "-time";
    extraConfig = ''
      [urgency=low]
      border-color=#282a36
      [urgency=normal]
      border-color=#bd93f9
      [urgency=high]
      border-color=#ff5555
      default-timeout=0
      [category=mpd]
      default-timeout=2000
      group-by=category'';
  };
}
