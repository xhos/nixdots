{config, ...}: {
  services.mako = {
    enable = false;
    settings = {
      font = "Hack 12";
      anchor = "top-right";
      background-color = "#${config.lib.stylix.colors.base00}66";
      default-timeout = 3000;
      height = 150;
      width = 300;
      border-radius = 5;
      icons = true;
      text-color = "#f8f8f2";
      layer = "overlay";
      sort = "-time";
    };
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
