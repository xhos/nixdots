{ inputs, config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.default.lock == "hyprlock" && config.default.de == "hyprland") {

    programs.hyprlock = with config.lib.stylix.colors; {
      enable = true;

      settings = {
        # BACKGROUND
        background = {
          path = "${config.stylix.image}";
          # path = "/etc/nixos/home/shared/walls/tokyo-night-storm.jpg";
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };

        # GENERAL
        general = {
          no_fade_in = false;
          grace = 0;
          disable_loading_bar = false;
        };

        # Profie-Photo
        image = {
          path = "~/.config/hypr/vivek.png";
          border_size = 2;
          border_color = "rgba(255, 255, 255, 0)";
          size = 130;
          rounding = -1;
          rotate = 0;
          reload_time = -1;
          reload_cmd = "";
          position = "0, 40";
          halign = "center";
          valign = "center";
        };

        # Day-Month-Date
        label = [
          {
            text = "cmd[update:1000] echo -e \"$(date +\"%A, %B %d\")\"";
            color = "rgba(216, 222, 233, 0.70)";
            font_size = 25;
            font_family = "SF Pro Display Bold";
            position = "0, 350";
            halign = "center";
            valign = "center";
          }

          # Time
          {
            text = "cmd[update:1000] echo \"<span>$(date +\"%H:%M\")</span>\"";
            color = "rgba(216, 222, 233, 0.70)";
            font_size = 120;
            font_family = "SF Pro Display Bold";
            position = "0, 250";
            halign = "center";
            valign = "center";
          }

          # USER
          {
            text = "    $USER";
            color = "rgba(216, 222, 233, 0.80)";
            outline_thickness = 2;
            dots_size = 0.2;
            dots_spacing = 0.2;
            dots_center = true;
            font_size = 18;
            font_family = "SF Pro Display Bold";
            position = "0, -130";
            halign = "center";
            valign = "center";
          }
          # CURRENT SONG
          {
            text = "cmd[update:1000] echo \"$(sh /etc/nixos/modules/home/opt/hyprland/hyprlock/songdetail.sh)\"";
            color = "rgba(255, 255, 255, 0.6)";
            font_size = 18;
            font_family = "JetBrains Mono Nerd, SF Pro Display Bold";
            position = "0, 50";
            halign = "center";
            valign = "bottom";
          }
        ];

        # USER-BOX
        # shape = {
        #   size = "300, 60";
        #   color = "rgba(255, 255, 255, .1)";
        #   rounding = -1;
        #   border_size = 0;
        #   border_color = "rgba(253, 198, 135, 0)";
        #   rotate = 0;
        #   xray = false;
        #   position = "0, -130";
        #   halign = "center";
        #   valign = "center";
        # };

        # INPUT FIELD
        "input-field" = {
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          font_family = "SF Pro Display Bold";
          placeholder_text = "<i><span foreground=\"##ffffff99\">pswd</span></i>";
          hide_input = false;
          position = "0, -210";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}