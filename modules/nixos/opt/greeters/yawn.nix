{
  config,
  lib,
  inputs,
  ...
}: {
  config = lib.mkIf (config.greeter == "yawn") {
    services.greetd = {
      enable = true;
      settings.default_session.command = "${inputs.yawn.packages.x86_64-linux.default}/bin/yawn -cmd Hyprland -user xhos";
    };
  };
}
