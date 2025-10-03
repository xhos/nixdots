{pkgs, ...}: {
  imports = [../../modules/home];

  impermanence.enable = true;
  headless = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";

  modules.secrets.enable = true;

  shell = "zsh";
  prompt = "starship";
}
