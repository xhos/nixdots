{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.greeter == "yawn") {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    services.greetd = {
      enable = true;
      settings.default_session.command = "${inputs.yawn.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/yawn -cmd \"uwsm start hyprland-uwsm.desktop\" -user xhos -minimal";
    };
  };
}
