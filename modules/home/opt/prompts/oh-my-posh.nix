{ config, lib, pkgs, ... }:

{ #TODO Config colors here
  config = lib.mkIf (config.default.prompt == "oh-my-posh") {
    home.packages = with pkgs; [ oh-my-posh ];

    programs.oh-my-posh = with config.lib.stylix.colors; {
      enable = true;
      enableZshIntegration = true;

      #:schema https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json
      #:original config https://github.com/dreamsofautonomy/zen-omp/blob/main/zen.toml
      settings = {
        version = 2;
        final_space = true;
        console_title_template = "{{ .Shell }} in {{ .Folder }}";
        blocks = [
          {
            type = "prompt";
            alignment = "left";
            newline = true;
            segments = [
              {
                type = "path";
                style = "plain";
                background = "transparent";
                foreground = "blue";
                template = "{{ .Path }}";
                properties.style = "full";
              }
              {
                type = "git";
                style = "plain";
                foreground = "p:grey";
                background = "transparent";
                template = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}</>";
                properties.branch_icon = "";
                properties.commit_icon = "@";
                properties.fetch_status = true;
              }
            ];
          }
          {
            type = "rprompt";
            overflow = "hidden";

            segments = [{
              type = "executiontime";
              style = "plain";
              foreground = "yellow";
              background = "transparent";
              template = "{{ .FormattedMs }}";
              properties.threshold = 5000;
            }];
          }
          {
            type = "prompt";
            alignment = "left";
            newline = true;

            segments = [{ 
              type = "text";
              style = "plain";
              foreground_templates = [
                "{{if gt .Code 0}}red{{end}}"
                "{{if eq .Code 0}}magenta{{end}}"
              ];
              background = "transparent";
              template = "❯";
            }];
          }
        ];

        transient_prompt = {
          foreground_templates = [
            "{{if gt .Code 0}}red{{end}}"
            "{{if eq .Code 0}}magenta{{end}}"
          ];
          background = "transparent";
          template = "❯ ";
        };

        secondary_prompt = {
          foreground = "magenta";
          background = "transparent";
          template = "❯❯ ";
        };
      };
    };
  };
}
