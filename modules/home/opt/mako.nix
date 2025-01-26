{config, ...}: {
  services.mako = {
    enable = true;
    font = "Hack 12";
    anchor = "top-right";
    backgroundColor = "#${config.lib.stylix.colors.base00}66"; # Updated to include alpha value for transparency
    borderSize = 2;
    defaultTimeout = 3000;
    height = 150;
    width = 300;
    borderRadius = 5;
    icons = true;
    textColor = "#f8f8f2";
    layer = "overlay";
    sort = "-time";
    extraConfig = ''
      [urgency=low]
      border-color=#${config.lib.stylix.colors.base00}
      [urgency=normal]
      border-color=#${config.lib.stylix.colors.base03}
      [urgency=high]
      border-color=#ff5555
      default-timeout=0
      [category=mpd]
      default-timeout=2000
      group-by=category'';
  };
}
