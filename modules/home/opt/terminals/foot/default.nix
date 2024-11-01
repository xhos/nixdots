{
  config,
  lib,
  ...
}:
lib.mkIf (config.default.terminal == "foot") {
  home.sessionVariables.TERMINAL = "foot";

  # https://codeberg.org/dnkl/foot/src/branch/master/foot.ini
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        shell = config.default.shell;
        app-id = "foot";
        title = "foot";
        locked-title = "no";
        term = "xterm-256color";
        resize-delay-ms = 100;
        selection-target = "primary";
        bold-text-in-bright = "yes";
        word-delimiters = ",│`|:\"'()[]{}<>";
      };

      bell = {
        urgent = "yes";
        notify = "yes";
        command = "notify-send bell";
        command-focused = "no";
      };

      cursor = {
        style = "beam";
        beam-thickness = 2;
      };

      desktop-notifications = {
        command = "notify-send -DDa \${app-id} -i \${app-id} \${title} \${body}";
      };

      scrollback = {
        lines = 10000;
        multiplier = 3;
      };
    };
  };
}
