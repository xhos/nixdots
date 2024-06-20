{ inputs, config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.default.lock == "hyprlock" && config.default.de == "hyprland") {

    programs.hyprlock = with config.lib.stylix.colors; {
      enable = true;

      settings = {
        general = {
          no_fade_in = false;
          grace = 0;
          disable_loading_bar = true;
        };

        background = {
          path = "${config.wallpaper}";

          blur_passes = 3;
          blur_radius = 10;
          contrast = 0.8916;
          brightness = 0.6172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };

        input-field = {
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgb(${config.background})";
          font_color = "rgb(${config.text})";
          fade_on_empty = false;
          font_family = "JetBrainsMono Nerd Font Mono";
          placeholder_text = "pswd";
          hide_input = false;
          position = "0, 0";
          halign = "center";
          valign = "center";
        };
        

        label = [
          # { # time is not possible, or it is i just do not care
          #   # text = "cmd[update:1000] echo ..\"$(date +..\"%-I:%M%p..\")";
          #   # text = builtins.toString(builtins.currentTime);
          #   text = builtins.readFile "${pkgs.runCommand "timestamp" { env.when = builtins.currentTime; } "echo -n `date -d @$when +%Y-%m-%d_%H-%M-%S` > $out"}";
          #   # color = "#${config.accent}";
          #   color = "rgb(${config.text})";
          #   font_size = 120;
          #   font_family = "JetBrainsMono Nerd Font Mono";
          #   position = "0, -300";
          #   halign = "center";
          #   valign = "top";
          # } 
          {
            # need to switch with --impure or it won't work
            text = "Hi there, ${builtins.getEnv "USER"}";
            color = "rgb(${config.text})";
            font_size = 25;
            font_family = "JetBrainsMono Nerd Font Mono";
            position = "0, 80";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
