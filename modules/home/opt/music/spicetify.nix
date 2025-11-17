{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
    lib.mkIf config.modules.spicetify.enable {
      enable = true;
      theme = spicePkgs.themes.text;
      enabledExtensions = with spicePkgs.extensions; [
        shuffle
        hidePodcasts
        allOfArtist
      ];
    };
}
