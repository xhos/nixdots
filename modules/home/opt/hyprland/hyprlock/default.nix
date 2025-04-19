{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.default.lock == "hyprlock" && config.default.de == "hyprland") {
    programs.hyprlock = with config.lib.stylix.colors; {
      enable = true;

      extraConfig = ''
        -------------------- ADJUSTMENT --------------------

        $img                        = /etc/nixos/modules/home/opt/hyprland/hyprlock/assets
        $wallpaper                  = /home/xhos/Pictures/marathon2.jpg
        $widget                     = /etc/nixos/modules/home/opt/hyprland/hyprlock

        # COLORS
        $background                 = rgba(0, 0, 0, 0) #transparent
        $foreground                 = rgba(255, 255, 255, 1.0)
        $foreground-alt             = rgba(255, 255, 255, 0.3)
        $color1                     =

        $fail                       = rgba(221, 8, 8, 0.8)
        $green                      = rgba(196,252,4,1.0)


        # FONT
        # KH Interference
        # MonoSpec
        # Synchro
        $title                      = Maratype
        $main                       = Ndot55
        $pixel                      = KH Interference
        $alt                        = LetteraMonoLL Bold
        $jp                         = Noto Sans CJK JP



        --------------------- GENERAL --------------------

        general = {
            disable_loading_bar     = true,
            hide_cursor             = true,
            ignore_empty_input      = true,
            immediate_render        = true
        }



        -------------------- BACKGROUND --------------------

        background {
            monitor                 =
            path                    = $wallpaper
            blur_passes             = 2
            blur_size               = 5
            contrast                = 0.8916
            brightness              = 0.8172
            vibrancy                = 0.1696
            vibrancy_darkness       = 0.0

        }

        -------------------- RIGHT BAR --------------------
        # DATE (LAST NUMBER)
        label {
            monitor                 =
            text                    = cmd[update:1000] echo -e "$(date +"%d")"
            color                   = $green
            font_family             = Nimbus Sans L Thin
            font_size               = 40
            rotate                  = -90
            position                = -33, -77
            halign                  = right
            valign                  = top
        }

        # DOT
        image {
            monitor                 =
            path                    = $img/g-2x2dot.png
            size                    = 6
            rounding                = 0
            border_size             = 0
            rotate                  = -90

            position                = -48, -148
            halign                  = right
            valign                  = top
            color                   = $foreground
        }

        # MONTH NUMBER
        label {
            monitor                 =
            text                    = cmd[update:1000] echo -e "$(date +"%m")"
            color                   = $green
            font_family             = Nimbus Sans L Thin
            font_size               = 40
            rotate                  = -90
            position                = -33, -165
            halign                  = right
            valign                  = top
        }

        # DOT
        image {
            monitor                 =
            path                    = $img/g-2x2dot.png
            size                    = 6
            rounding                = 0
            border_size             = 0
            rotate                  = -90

            position                = -48, -230
            halign                  = right
            valign                  = top
            color                   = $foreground
        }

        # YEAR
        label {
            monitor                 =
            text                    = cmd[update:1000] echo -e "$(date +"%Y")"
            color                   = $green
            font_family             = Nimbus Sans Black
            font_size               = 40
            rotate                  = -90
            position                = -34, -250
            halign                  = right
            valign                  = top
        }

        # LEFT DOT
        image {
            monitor                 =
            path                    = $img/g-2x2dot.png
            size                    = 6
            rounding                = 0
            border_size             = 0
            rotate                  = -90

            position                = -67, -470
            halign                  = right
            valign                  = top
            color                   = $foreground
        }

        # RIGHT DOT
        image {
            monitor                 =
            path                    = $img/g-2x2dot.png
            size                    = 6
            rounding                = 0
            border_size             = 0
            rotate                  = -90

            position                = -30, -470
            halign                  = right
            valign                  = top
            color                   = $foreground
        }

        # BARCODE
        image {
            monitor                 =
            path                    = $img/g-barcode.png
            size                    = 24
            rounding                = 0
            border_size             = 0
            rotate                  = -90

            position                = -40, -570
            halign                  = right
            valign                  = top
            color                   = $foreground
        }

        # CROSS
        image {
            monitor                 =
            path                    = $img/g-cross.png
            size                    = 24
            rounding                = 0
            border_size             = 0
            rotate                  = -90

            position                = -40, -710
            halign                  = right
            valign                  = top
            color                   = $foreground
        }

        # CIRCLE
        image {
            monitor                 =
            path                    = $img/g-circle.png
            size                    = 24
            rounding                = 0
            border_size             = 0
            rotate                  = -90

            position                = -40, -770
            halign                  = right
            valign                  = top
            color                   = $foreground
        }

        # CLOCK-HOUR
        label {
            monitor                 =
            text                    = cmd[update:1000] echo "<b><big> $(date +"%H") </big></b>" # 12-h format (%H for 24-h format)
            color                   = $green
            font_family             = $pixel
            font_size               = 30
            rotate                  = -90
            position                = -30, -800
            halign                  = right
            valign                  = top
        }

        # CLOCK-MINUTE
        label {
            monitor                 =
            text                    = cmd[update:1000] echo "<b><big> $(date +"%M") </big></b>"
            color                   = $green
            font_family             = $pixel
            font_size               = 30
            rotate                  = -90
            position                = -30, -870
            halign                  = right
            valign                  = top
        }

        # TAXI
        image {
            monitor                 =
            path                    = $img/g-taxi.png
            size                    = 24
            rounding                = 0
            border_size             = 0
            rotate                  = -90

            position                = -42, -970
            halign                  = right
            valign                  = top
            color                   = $foreground
        }

        -------------------- CENTER --------------------
        # NAME
        label {
            monitor                 =
            # text                    = ESCAPE WILL MAKE ME GOD
            text                    = OZYMANDIAS
            in the heavens they are waiting
            TAU CETI IV    # text                    = cmd[] echo "HELLO $(whoami) PLEASE LOGIN"
            color                   = $green
            font_family             = Maratype
            font_size               = 110

            position                = 30, -77
            halign                  = left
            valign                  = top
        }

        label {
            monitor                 =
            # text                    = in the heavens they are waiting / TAU CETI IV
            text                    = ESCAPE WILL MAKE ME GOD / TAU CETI IV
            color                   = $green
            font_family             = $pixel
            font_size               = 20

            position                = 34, -230
            halign                  = left
            valign                  = top
        }

        # PLUS
        image {
            monitor                 =
            path                    = $img/g-plus.png
            size                    = 24
            rounding                = 0
            border_size             = 0
            rotate                  = -90

            position                = 640, -140
            halign                  = left
            valign                  = top
            color                   = $foreground
        }

        -------------------- ELEMENT --------------------

        # USERBOX TOP LINE
        shape {
            monitor                 =
            size                    = 140, 1
            color                   = $green
            rounding                = -1

            position                = 150, 57
            halign                  = left
            valign                  = bottom
        }

        # USERBOX BOT LINE
        shape {
            monitor                 =
            size                    = 140, 1
            color                   = $green
            rounding                = -1

            position                = 150, 32
            halign                  = left
            valign                  = bottom
        }

        -------------------- TEXT --------------------

        # NAME
        label {
            monitor                 =
            text                    = cmd[] echo "$(whoami)"
            color                   = $green
            font_family             = $alt
            font_size               = 11

            position                = -1643, 61
            halign                  = right
            valign                  = bottom
        }
        --------------------- USER --------------------

        # AVATAR
        image {
            monitor                 =
            path                    = $img/pfp.png
            border_color            = $foreground-alt
            border_size             = 0
            size                    = 110
            rounding                = 6
            rotate                  = 0
            opacity                 = 1

            reload_time             = -1
            reload_cmd              =

            position                = 30, 30
            halign                  = left
            valign                  = bottom
        }



        -------------------- INPUT --------------------

        # INPUT BOX
        input-field {
            monitor                 =
            size                    = 80, 35
            rounding                = 3
            outline_thickness       = 0
            hide_input              = false

            inner_color             = $background
            outer_color             = $background
            check_color             = $background

            dots_size               = 0.35
            dots_spacing            = 0.3
            dots_center             = true
            dots_rounding           = -1

            font_family             = $alt
            font_color              = $green

            placeholder_text        = PASSCODE
            fail_text               = WRONG PASSCODE <b>($ATTEMPTS)</b>

            fade_on_empty           = false
            fade_timeout            = 200
            fail_transition         = 300

            position                = -1625, 24
            halign                  = right
            valign                  = bottom
        }



        -------------------- WIDGET --------------------

        BATTERY
        label {
            monitor             =
            text                = cmd[update:1000] sh /etc/nixos/modules/home/opt/hyprland/hyprlock/battery.sh
            color               = $green
            font_family         = $main Bold
            font_size           = 14


            position            = -1630, 118
            halign              = right
            valign              = bottom
            zindex              = 1
        }


      '';
    };
  };
}
