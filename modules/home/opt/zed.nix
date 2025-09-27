{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.zed-editor = lib.mkIf (config.headless != true) {
    enable = true;
    extensions = [
      "nix"
      "wakatime"
    ];
    extraPackages = [inputs.tsutsumi.packages.${pkgs.system}.wakatime-ls];
    # // Zed settings
    # //
    # // For information on how to configure Zed, see the Zed
    # // documentation: https://zed.dev/docs/configuring-zed
    # //
    # // To see all of Zed's default settings without changing your
    # // custom settings, run the `zed: Open Default Settings` command
    # // from the command palette

    # userSettings = {
    #   "icon_theme": "Material Icon Theme",
    #   "project_panel": {
    #     "dock": "left",
    #     "indent_size": 12,
    #     "entry_spacing": "standard",
    #     "indent_guides": {
    #       "show": "never"
    #     },
    #     "scrollbar": {
    #       "show": "never"
    #     }
    #   },
    #   "base_keymap": "VSCode",
    #   "vim_mode": false,
    #   "assistant": {
    #     "version": "2",
    #     "default_model": {
    #       "provider": "ollama",
    #       "model": "llama3.1:latest"
    #     }
    #   },
    #   # "ui_font_size": 16,
    #   # "buffer_font_size": 16,
    #   # "tab_size": 2,
    # #   "theme": {
    # #     "mode": "system",
    # #     "light": "Tokyo Night",
    # #     "dark": "Tokyo Night Storm"
    # #   },
    # #   "experimental.theme_overrides": {
    # #     "renamed.background": "#d",
    # #     "search.match_background": "#FFFFFF20",
    # #     "ghost_element.background": "#00000010",
    # #     "ghost_element.hover": "#00000099",
    # #     "background.appearance": "blurred",
    # #     "background": "#00000066",
    # #     "editor.background": "#00000010",
    # #     "editor.gutter.background": "#00000010",
    # #     "title_bar.background": "#000000DF",
    # #     "toolbar.background": "#00000010",
    # #     "terminal.background": "#00000000",
    # #     "status_bar.background": "#000000DF",
    # #     "tab.active_background": "#000000",
    # #     "tab.inactive_background": "#00000000",
    # #     "tab_bar.background": "#00000010",
    # #     "panel.background": "#00000010",
    # #     "border": "#00000000",
    # #     "border.variant": "#00000000",
    # #     "scrollbar.track.border": "#00000000",
    # #     "scrollbar.track.background": "#00000000",
    # #     "scrollbar.thumb.background": "#00000000",
    # #     "scrollbar.thumb.hover.background": "#00000000",
    # #     "scrollbar.thumb.active.background": "#00000000",
    # #     "scrollbar.thumb.border": "#FFFFFF90",
    # #     "editor.line_highlight": "#00000000",
    # #     "editor.active_line.background": "#00000000",
    # #     "editor.selection.background": "#00000000",
    # #     "editor.selection.foreground": "#00000000",
    # #     "editor.selection.border": "#00000000",
    # #     "editor.selection.inactive.foreground": "#00000000",
    # #     "editor.selection.inactive.border": "#00000000",
    # #     "editor.selection.active.background": "#00000000",
    # #     "editor.selection.active.foreground": "#00000000",
    # #     "editor.selection.active.border": "#00000000",
    # #     "editor.selection.inactive.background": "#00000000"
    # #   }
    # # }

    # #   # everything inside of these brackets are Zed options.
    # #   # userSettings = {
    # #   #   assistant = {
    # #   #     enabled = true;
    # #   #     version = "2";
    # #   #     default_open_ai_model = null;
    # #   #     # PROVIDER OPTIONS
    # #   #     # zed.dev models { claude-3-5-sonnet-latest } requires github connected
    # #     # anthropic models { claude-3-5-sonnet-latest claude-3-haiku-latest claude-3-opus-latest  } requires API_KEY
    # #     # copilot_chat models { gpt-4o gpt-4 gpt-3.5-turbo o1-preview } requires github connected
    # #     default_model = {
    # #       provider = "zed.dev";
    # #       model = "claude-3-5-sonnet-latest";
    # #     };

    # #     # inline_alternatives = [
    # #     #     {
    # #     #         provider = "copilot_chat";
    # #     #         model = "gpt-3.5-turbo";
    # #     #     }
    # #     # ];
    # #   };

    # #   hour_format = "hour24";
    # #   auto_update = false;
    # #   terminal = {
    # #     alternate_scroll = "off";
    # #     blinking = "off";
    # #     copy_on_select = false;
    # #     dock = "bottom";

    # #     detect_venv = {
    # #       on = {
    # #         directories = [".env" "env" ".venv" "venv"];
    # #         activate_script = "default";
    # #       };
    # #     };

    # #     font_family = "Hack";
    # #     font_features = null;
    # #     font_size = null;
    # #     line_height = "comfortable";
    # #     option_as_meta = false;
    # #     button = false;
    # #     shell = "system";
    # #     #{
    # #     #                    program = "zsh";
    # #     #};
    # #     toolbar = {
    # #       title = true;
    # #     };
    # #     working_directory = "current_project_directory";
    # #   };

    # #   lsp = {
    # #     nix = {
    # #       binary = {
    # #         path_lookup = true;
    # #       };
    # #     };
    # #   };

    # #   # tell zed to use direnv and direnv can use a flake.nix enviroment.
    # #   load_direnv = "shell_hook";
    # #   base_keymap = "VSCode";

    # #   theme = {
    # #     mode = "system";
    # #     light = "Tokyo Night";
    # #     dark = "Tokyo Night";
    # #   };

    # #   show_whitespaces = "all";
    # #   ui_font_size = 16;
    # #   buffer_font_size = 16;
    # #   ui_font_family = "Hack";

    # #   # "experimental.theme_overrides" = {
    # #   #   "background.appearance" = "blurred";
    # #   #   "background" = "#16161e80";
    # #   #   "panel.background" = "#00000000";
    # #   #   "editor.background" = "#00000000";
    # #   #   "tab_bar.background" = "#00000000";
    # #   #   "terminal.background" = "#00000000";
    # #   #   "toolbar.background" = "#00000000";
    # #   #   "tab.inactive_background" = "#00000000";
    # #   #   "tab.active_background" = "#3f3f4650";
    # #   #   "border" = "#00000000";
    # #   #   "status_bar.background" = "#16161e80";
    #   #   "title_bar.background" = "#16161e80";
    #   #   "border.variant" = "#00000000";
    #   #   "scrollbar.track.background" = "#00000000";
    #   #   "scrollbar.track.border" = "#00000000";
    #   #   "scrollbar.thumb.background" = "#00000000";
    #   #   "scrollbar.thumb.border" = "#00000000";
    #   #   "elevated_surface.background" = "#00000090";
    #   #   "surface.background" = "#00000090";
    #   #   "editor.active_line_number" = "#ffffffcc";
    #   #   "editor.gutter.background" = "#00000000";
    #   #   "editor.indent_guide" = "#ffffff30";
    #   #   "editor.indent_guide_active" = "#ffffff80";
    #   #   "editor.line_number" = "#ffffff80";
    #   #   "editor.active_line.background" = "#3f3f4640";
    #   # };
    # };
  };
}
