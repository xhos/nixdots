{ inputs, pkgs, lib, config, ... }: {
  theme = "apathy";

  imports = [
    ../../modules/home
  ];

  # xsession.scriptPath = ".hm-xsession";

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
}
