{
  config,
  lib,
  ...
}: {
  home.sessionVariables = {
    WAKATIME_HOME = "${config.xdg.configHome}/wakatime";
    TERMINAL = lib.mkDefault "foot";
  };
}
