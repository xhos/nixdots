{pkgs, ...}: {
  imports = [
    ../../modules/home
  ];

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";

  default = {
    shell = "zsh";
    prompt = "starship";
  };
}
