{config, ...}: {
  home.sessionVariables = {
    WAKATIME_HOME = "${config.xdg.configHome}/wakatime";
  };
}
