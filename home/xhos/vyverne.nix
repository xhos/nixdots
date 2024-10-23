{ inputs, pkgs, lib, config, ... }: {
  theme = "tokyo-night-storm";

  imports = [ ../../modules/home ];

  modules = {
    rofi.enable      = true;
    spicetify.enable = true;
    firefox.enable   = true;
    discord.enable   = true;
    nvidia.enable    = true;
  };

  default = {
    de       = "hyprland";
    bar      = "waybar";
    lock     = "hyprlock";
    shell    = "fish";
    prompt   = "starship";
    terminal = "alacritty";
  };

  home.packages = with pkgs; [
    (vscode.override { commandLineArgs = [ "--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];})
  ];

  programs.waybar.settings.mainBar.output = [ "DP-1" ];
}
