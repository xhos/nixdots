{ config, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = with config.lib.stylix.colors; ''
      {
        "$schema": "https://github.com/LinusDierheimer/fastfetch/raw/master/data/config.json",

      }
    '';
  };
}