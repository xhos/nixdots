{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  config = lib.mkIf config.modules.spicetify.enable {
    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.lucid;
  

      # customColorScheme = with config.lib.stylix.colors; {
      #   text = "${base05}";
      #   subtext = "${base05}";
      #   sidebar-text = "${base05}";
      #   main = "${base00}";
      #   sidebar = "${base01}";
      #   player = "${base01}";
      #   card = "${base00}";
      #   shadow = "${base03}";
      #   selected-row = "${base03}";
      #   button = "${base0F}";
      #   button-active = "${base05}";
      #   button-disabled = "${base0E}";
      #   tab-active = "${base03}";
      #   notification = "${base0A}";
      #   notification-error = "${base0F}";
      #   misc = "${base05}";
      #   alt-text = "${base05}";
      #   player-bar-bg = "${base01}";
      #   accent = "${base06}";
      # };

      enabledExtensions = with spicePkgs.extensions; [
        beautifulLyrics
        ({
          # The source of the extension
          # make sure you're using the correct branch
          # It could also be a sub-directory of the repo

          src = 
          let
            catsync = pkgs.fetchFromGitHub {
              owner = "BlafKing";
              repo = "spicetify-cat-jam-synced";
              rev = "e7bfd49fcc13457bbc98e696294cf5cf43eb6c31";
              hash = "sha256-pyYa5i/gmf01dkEF9I2awrTGLqkAjV9edJBsThdFRv8=";
            };
          in "${catsync}/marketplace";
          name = "cat-jam.js";
        })
      ];
    };
  };
}
