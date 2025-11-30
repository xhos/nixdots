{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.greeter == "yawn") {
    services.greetd = {
      enable = true;
      settings.default_session.command = "${inputs.yawn.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/yawn -cmd Hyprland -user xhos -minimal"; 
    };
  };
}
