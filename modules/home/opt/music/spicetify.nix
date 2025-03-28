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
      theme = spicePkgs.themes.comfy;

      customColorScheme = with config.lib.stylix.colors; {
        text = "${base05}";
        subtext = "${base05}";
        sidebar-text = "${base05}";
        main = "${base00}";
        sidebar = "${base01}";
        player = "${base01}";
        card = "${base00}";
        shadow = "${base03}";
        selected-row = "${base03}";
        button = "${base0F}";
        button-active = "${base05}";
        button-disabled = "${base0E}";
        tab-active = "${base03}";
        notification = "${base0A}";
        notification-error = "${base0F}";
        misc = "${base05}";
        alt-text = "${base05}";
        player-bar-bg = "${base01}";
        accent = "${base06}";
      };

      enabledExtensions = with spicePkgs.extensions; [
        beautifulLyrics
        adblock
      ];

      enabledCustomApps = with spicePkgs.apps; [
        betterLibrary
        reddit
        newReleases
      ];
    };
  };
}
