# https://codeberg.org/dnkl/foot/src/branch/master/foot.ini
{
  config,
  lib,
  ...
}:
lib.mkIf (config.default.terminal == "foot") {
  home.sessionVariables.TERMINAL = "foot";
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        app-id = "foot";
        title = "foot";
        locked-title = "no";
        term = "xterm-256color";
        # vertical-letter-offset = "-0.75";
        pad = "12x21 center";
        resize-delay-ms = 100;
        notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        selection-target = "primary";
        # box-drawings-uses-font-glyphs = "yes";
        bold-text-in-bright = "yes";
        word-delimiters = ",│`|:\"'()[]{}<>";
        font="monospace:size=12";
        font-size-adjustment="150%";
      };
      cursor = {
        style = "beam";
        beam-thickness = 2;
      };
      scrollback = {
        lines = 10000;
        multiplier = 3;
      };

      bell = {
        urgent = "yes";
        notify = "yes";
        command = "notify-send bell";
        command-focused = "no";
      };
      url = {
        launch = "xdg-open \${url}";
        label-letters = "sadfjklewcmpgh";
        osc8-underline = "url-mode";
        protocols = "http, https, ftp, ftps, file, gemini, gopher, irc, ircs";

        uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      key-bindings = {
        show-urls-launch = "Control+Shift+u";
        unicode-input = "Control+Shift+i";
      };
      mouse-bindings = {
        # selection-override-modifiers = "Shift";
        # primary-paste = "BTN_MIDDLE";
        # select-begin = "BTN_LEFT";
        # select-begin-block = "Control+BTN_LEFT";
        # select-extend = "BTN_RIGHT";
        # select-extend-character-wise = "Control+BTN_RIGHT";
        # select-word = "BTN_LEFT-2";
        # select-word-whitespace = "Control+BTN_LEFT-2";
        #select-row = "BTN_LEFT-3";
      };

      colors = with config.lib.stylix.colors; {
        # cursor_bg = "#${base05}";
        # cursor_border = "#${base05}";
        # cursor_fg = "#${base0A}";
        # split = "#${base01}";

        foreground="${base05}";
        background="${base00}";

        regular0="${base01}";
        regular1="${base08}";
        regular2="${base0B}";
        regular3="${base0A}";
        regular4="${base0D}";
        regular5="${base0E}";
        regular6="${base0C}";
        regular7="${base05}";

        bright0="${base03}";
        bright1="${base08}";
        bright2="${base0B}";
        bright3="${base0A}";
        bright4="${base0D}";
        bright5="${base0E}";
        bright6="${base0C}";
        bright7="${base0F}";

        selection-foreground="${base05}";
        selection-background="${base01}";

        
        # search-box-no-match="181926 ed8796";
        # search-box-match="cad3f5 363a4f";

        # jump-labels="181926 f5a97f";
        # urls="8aadf4";
      };
    };
  };
}
