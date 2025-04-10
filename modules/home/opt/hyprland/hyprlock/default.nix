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
        $wallpaper                  = /home/xhos/Pictures/beams.jpg
        $widget                     = /etc/nixos/modules/home/opt/hyprland/hyprlock

        # COLORS
        $background                 = rgba(0, 0, 0, 0) #transparent
        $foreground                 = rgba(255, 255, 255, 1.0)
        $foreground-alt             = rgba(255, 255, 255, 0.3)
        $color1                     =

        $fail                       = rgba(221, 8, 8, 0.8)

        # FONT
        $main                       = Ndot55
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



        -------------------- ELEMENT --------------------

        # TOP LINE
        shape {
            monitor                 =
            size                    = 1860, 2
            color                   = $foreground
            rounding                = -1 # circle

            position                = 0, 370
            halign                  = center
            valign                  = center
        }

        # ICON-ARROW
        image {
            monitor                 =
            path                    = $img/arrow.png
            size                    = 30
            rounding                = 0
            border_size             = 0

            position                = 150, 95
            halign                  = left
            valign                  = bottom
        }

        # ICON-STAR
        image {
            monitor                 =
            path                    = $img/star-circle.png
            size                    = 53
            rounding                = 0
            border_size             = 0

            position                = 13, -400
            halign                  = left
            valign                  = center
        }

        # ICON-LOGO
        image {
            monitor                 =
            path                    = $img/logo.png
            size                    = 70
            rounding                = 0
            border_size             = 0

            position                = 0, -5
            halign                  = center
            valign                  = bottom
            zindex                  = -1
        }


        # ICON-SMILEY
        image {
            monitor                 =
            path                    = $img/smiley.png
            size                    = 27
            rounding                = 0
            border_size             = 0

            position                = 24, 55
            halign                  = left
            valign                  = center
            zindex                  = 1
        }

        # ICON-GLOBE
        image {
            monitor                 =
            path                    = $img/globe.png
            size                    = 23
            rounding                = 0
            border_size             = 0

            position                = 26, 85
            halign                  = left
            valign                  = center
        }

        # USERBOX TOP LINE
        shape {
            monitor                 =
            size                    = 140, 1
            color                   = $foreground
            rounding                = -1

            position                = 150, 57
            halign                  = left
            valign                  = bottom
        }

        # USERBOX BOT LINE
        shape {
            monitor                 =
            size                    = 140, 1
            color                   = $foreground
            rounding                = -1

            position                = 150, 32
            halign                  = left
            valign                  = bottom
        }

        # XRAY BOX CENTER
        shape {
            monitor                 =
            size                    = 30, 30
            color                   = $background # no fill
            rounding                = 0
            border_color            = $foreground
            border_size             = 0

            position                = 0, -140
            halign                  = center
            valign                  = center
            xray                    = true
        }

        # XRAY BOX LEFT
        shape {
            monitor                 =
            size                    = 30, 30
            color                   = $background # no fill
            rounding                = 0
            border_color            = $foreground
            border_size             = 0

            position                = -35, -140
            halign                  = center
            valign                  = center
            xray                    = true
        }

        # XRAY BOX RIGHT
        shape {
            monitor                 =
            size                    = 30, 30
            color                   = $background # no fill
            rounding                = 0
            border_color            = $foreground
            border_size             = 0

            position                = 35, -140
            halign                  = center
            valign                  = center
            xray                    = true
        }

        # XRAY BOX BOT-RIGHT
        # shape {
        #     monitor                 =
        #     size                    = 30, 30
        #     color                   = $background # no fill
        #     rounding                = 0
        #     border_color            = $foreground
        #     border_size             = 0

        #     position                = -35, 75
        #     halign                  = right
        #     valign                  = bottom
        #     xray                    = true
        # }



        -------------------- TIME & DATE --------------------

        # CLOCK-HOUR
        label {
            monitor                 =
            text                    = cmd[update:1000] echo "<b><big> $(date +"%I") </big></b>" # 12-h format (%H for 24-h format)
            color                   = $foreground
            font_family             = $main
            font_size               = 90

            position                = 0, -60
            halign                  = left
            valign                  = top
        }

        # CLOCK-MINUTE
        label {
            monitor                 =
            text                    = cmd[update:1000] echo "<b><big> $(date +"%M") </big></b>"
            color                   = $foreground
            font_family             = $main
            font_size               = 90

            position                = 0, -190
            halign                  = left
            valign                  = top
        }

        # DATE
        label {
            monitor                 =
            text                    = cmd[update:1000] echo -e "$(date +"%a %B %d")"
            color                   = $foreground
            font_family             = $main
            font_size               = 50

            position                = -25, -190
            rotate                  = 90
            halign                  = right
            valign                  = top
        }

        # YEAR PILL
        shape {
            monitor                 =
            size                    = 60, 20
            color                   = $background # no fill
            rounding                = -1 # circle
            border_color            = $foreground
            border_size             = 1
            # -35 22
            position                = -30, -122
            halign                  = right
            valign                  = top
        }

        # YEAR
        label {
            monitor                 =
            text                    = cmd[update:1000] echo -e "$(date +"%Y")"
            color                   = $foreground
            font_family             = $alt
            font_size               = 10

            position                = -43, -128
            halign                  = right
            valign                  = top
        }



        -------------------- TEXT --------------------

        # NAME
        label {
            monitor                 =
            text                    = cmd[] echo "$(whoami)"
            color                   = $foreground
            font_family             = $alt
            font_size               = 11

            position                = -1643, 61
            halign                  = right
            valign                  = bottom
        }

        # TAG-LEFT
        label {
            monitor                 =
            text                    = LIVE
            color                   = $foreground
            font_family             = $alt
            font_size               = 10

            position                = 300, 344
            halign                  = left
            valign                  = center
        }

        # TAG-CENTER
        label {
            monitor                 =
            text                    = YOUR
            color                   = $foreground
            font_family             = $alt
            font_size               = 10

            position                = 0, 344
            halign                  = center
            valign                  = center
        }

        # TAG-RIGHT
        label {
            monitor                 =
            text                    = LIFE
            color                   = $foreground
            font_family             = $alt
            font_size               = 10

            position                = -300, 344
            halign                  = right
            valign                  = center
        }

        # TAG-BOT
        # label {
        #     monitor                 =
        #     text                    = NIXOS
        #     color                   = $foreground
        #     font_family             = $alt
        #     font_size               = 9

        #     position                = -35, 25
        #     halign                  = right
        #     valign                  = bottom
        # }

        # HIRAGANA
        label {
            monitor                 =
            text                    = かいぜん
            color                   = $foreground
            font_family             = $jp
            font_size               = 14

            position                = 0, 190
            halign                  = center
            valign                  = bottom
        }

        # QUOTES-TOP
        label {
            monitor                 =
            text                    = You can have everything and feel nothing.
            color                   = $foreground
            font_family             = Ndot55Caps
            font_size               = 12

            position                = 0, 130
            halign                  = center
            valign                  = bottom
        }

        # QUOTES-BOT
        label {
            monitor                 =
            text                    = What you resist, persists. What you accept, dissolves.    What you resist, persists. What you accept, dissolves.
            color                   = $foreground
            font_family             = Ndot55Caps
            font_size               = 12

            position                = 0, 115
            halign                  = center
            valign                  = bottom
        }



        --------------------- USER --------------------

        # AVATAR
        image {
            monitor                 =
            path                    = $img/pfp.jpg
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
            font_color              = $foreground

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

        # BATTERY
        label {
            monitor             =
            text                = cmd[update:1000] sh /etc/nixos/modules/home/opt/hyprland/hyprlock/battery.sh
            color               = $foreground
            font_family         = $main Bold
            font_size           = 14


            position            = -1630, 118
            halign              = right
            valign              = bottom
            zindex              = 1
        }

        # LOG
        label {
            monitor             =
            text                = cmd[update:3000] sh /etc/nixos/modules/home/opt/hyprland/hyprlock/log.sh
            color               = $foreground
            font_family         = Ndot55Caps
            font_size           = 12


            position            = -30, 30
            halign              = right
            valign              = bottom
            zindex              = 1
        }

        # CPU
        label {
            monitor             =
            text                = cmd[] echo "$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //')"
            color               = $foreground
            font_family         = Ndot55Caps
            font_size           = 12


            position            = -30, 45
            halign              = right
            valign              = bottom
            zindex              = 1
        }

        label {
            monitor             =
            text                = cmd[] echo "$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '\"')"
            color               = $foreground
            font_family         = Ndot55Caps
            font_size           = 12


            position            = -30, 60
            halign              = right
            valign              = bottom
            zindex              = 1
        }

        label {
            monitor             =
            text                = cmd[] echo "$(awk '{print "Uptime: " int($1/3600)"h " int(($1%3600)/60)"m"}' /proc/uptime)"
            color               = $foreground
            font_family         = Ndot55Caps
            font_size           = 12


            position            = -30, 75
            halign              = right
            valign              = bottom
            zindex              = 1
        }

        label {
            monitor             =
            text                = cmd[] echo "$(uname -m)"
            color               = $foreground
            font_family         = Ndot55Caps
            font_size           = 12


            position            = -30, 90
            halign              = right
            valign              = bottom
            zindex              = 1
        }

        label {
            monitor             =
            text                = cmd[] echo "$(cat /proc/sys/kernel/osrelease)"
            color               = $foreground
            font_family         = Ndot55Caps
            font_size           = 12


            position            = -30, 105
            halign              = right
            valign              = bottom
            zindex              = 1
        }
      '';
    };
  };
}
