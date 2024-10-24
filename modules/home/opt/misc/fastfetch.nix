{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "sixel";
        source = "/etc/nixos/home/shared/images/evanixlogo.png";
        width = 34;
        height = 17;
        padding = {
          top = 1;
        };
      };
      display = {
        separator = " -> ";
        constants = [
          "──────────────────────────────"
        ];
      };
      modules = [
        {
          type = "custom";
          format = " {#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37}  {#38}  {#39}       {#38}  {#37}  {#36}  {#35}  {#34}  {#33}  {#32}  {#31}  {#90}";
        }
        {
          type = "custom";
          format = "┌{$1}{$1}┐";
          outputColor = "90";
        }
        {
          type = "os";
          key = "{icon} OS";
          keyColor = "yellow";
        }
        {
          type = "kernel";
          key = "│ ├";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = "│ ├󰏖";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = "│ └";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = " DE/WM";
          keyColor = "blue";
        }
        {
          type = "lm";
          key = "│ ├󰧨";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = "│ └";
          keyColor = "blue";
        }
        {
          type = "host";
          key = "󰌢 PC";
          keyColor = "green";
        }
        {
          type = "cpu";
          key = "│ ├󰻠";
          keyColor = "green";
        }
        {
          type = "gpu";
          key = "│ ├󰍛";
          keyColor = "green";
        }
        {
          type = "disk";
          key = "│ ├";
          keyColor = "green";
        }
        {
          type = "memory";
          key = "│ └󰑭";
          keyColor = "green";
        }
        {
          type = "sound";
          key = " SND";
          keyColor = "cyan";
        }
        {
          type = "player";
          key = "│ ├󰥠";
          keyColor = "cyan";
        }
        {
          type = "media";
          key = "│ └󰝚";
          keyColor = "cyan";
        }
        {
          type = "custom";
          format = "└{$1}{$1}┘";
          outputColor = "90";
        }
        {
          type = "custom";
          format = " {#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37}  {#38}  {#39}       {#38}  {#37}  {#36}  {#35}  {#34}  {#33}  {#32}  {#31}  {#90}";
        }
      ];
    };
  };
}
