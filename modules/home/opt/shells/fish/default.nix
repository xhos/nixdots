{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.default.shell == "fish") {
    home.packages = with pkgs; [ fish ];
    programs.fish = {
      enable = true;
    };
  };
}