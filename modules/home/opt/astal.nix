{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  config = lib.mkIf (config.default.bar == "astal") {
    systemd.user.services.aard = {
      Unit.Description = "Astal Shell";
      Install.WantedBy = ["graphical-session.target"];
      Service = {
        ExecStart = "${inputs.aard.packages.${pkgs.system}.default}/bin/aard";
        Restart = "always";
        RestartSec = "5s";
      };
    };
  };
}
