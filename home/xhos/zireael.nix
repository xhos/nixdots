{ inputs, pkgs, lib, config, ... }: {
  theme = "tokyo night storm";

  imports = [
    ../../modules/home
  ];

  modules = {
    hyprland.enable  = true;
    rofi.enable      = true;
    spicetify.enable = true;
  };

  default = {
    de       = "hyprland";
    bar      = "ags";
    lock     = "hyprlock";
    terminal = "wezterm";
    prompt   = "oh-my-posh";
    shell    = "nu";
  };

  home = {
    packages = with pkgs; [
      (discord.override {withVencord = true;})
      scrcpy
      stremio
      yazi
      showmethekey
    ];
  };
}
