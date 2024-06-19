{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.default.prompt == "oh-my-posh") {
    home.packages = with pkgs; [ oh-my-posh ];
    programs.oh-my-posh = with config.lib.stylix.colors; {
      enable = true;
    };
  };
}
    
