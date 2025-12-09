{
  config,
  lib,
  ...
}:
lib.mkIf (config.terminal == "wezterm") {
  home.sessionVariables.TERMINAL = "wezterm";
  programs.wezterm = {
    enable = true;
    colorSchemes = with config.lib.stylix.colors; {
      followSystem = {
        # basic colors
        background = "#${base00}";
        cursor_bg = "#${base05}";
        cursor_border = "#${base05}";
        cursor_fg = "#${base0A}";
        foreground = "#${base05}";
        selection_bg = "#${base01}";
        selection_fg = "#${base05}";
        split = "#${base01}";

        # base16
        ansi = [
          "#${base01}"
          "#${base08}"
          "#${base0B}"
          "#${base0A}"
          "#${base0D}"
          "#${base0E}"
          "#${base0C}"
          "#${base05}"
        ];
        brights = [
          "#${base03}"
          "#${base08}"
          "#${base0B}"
          "#${base0A}"
          "#${base0D}"
          "#${base0E}"
          "#${base0C}"
          "#${base0F}"
        ];
      };
    };

    extraConfig = ''
      local wez = require('wezterm')
      return {
        default_prog     = { '${config.shell}' },
        -- cell_width = 0.85,

        -- Performance
        --------------
        enable_wayland   = true,
        scrollback_lines = 1024,

        -- Fonts
        --------
        font = wez.font_with_fallback({
          "FiraCode Nerd Font Mono",
          "Material Design Icons",
        }),
        bold_brightens_ansi_colors = true,
        font_rules = {
          {
            italic = true,
            font   = wez.font("FiraCode Nerd Font Mono", { italic = true })
          }
        },
        freetype_load_target = "Normal",
        font_size         = 12.0,
        line_height       = 1,
        harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },

        -- Bling
        --------
        color_scheme   = "followSystem",
        window_background_opacity = 0.6,
        default_cursor_style = "SteadyUnderline",
        enable_scroll_bar    = false,
        warn_about_missing_glyphs = false,

        -- Tabbar
        ---------
        enable_tab_bar               = true,
        use_fancy_tab_bar            = true,
        hide_tab_bar_if_only_one_tab = true,
        show_tab_index_in_tab_bar    = false,

        -- Miscelaneous
        ---------------
        window_close_confirmation = "NeverPrompt",
        inactive_pane_hsb         = {
          saturation = 1.0, brightness = 0.8
        },
        check_for_updates = false,
      }
    '';
  };
}
