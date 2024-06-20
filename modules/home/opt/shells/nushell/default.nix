{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.default.shell == "nushell") {
    home.packages = with pkgs; [ nushell ];
    programs.nushell = {
      enable = true;
    };
  };
}