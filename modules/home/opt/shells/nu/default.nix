{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.default.shell == "nu") {
    home.packages = with pkgs; [ nushell ];
    programs.nushell = {
      enable = true;

      configFile.text =  ''
        $env.config = {
          show_banner: false,
        }
      '';
    };
  };
}