{
  config,
  lib,
  inputs,
  ...
}:
lib.mkIf (config.default.terminal == "alacritty") {
  home.sessionVariables.TERMINAL = "alacritty";
  programs.alacritty = {
    enable = true;
    settings = {
      # window.opacity = 0.8;
    };
  };
}
