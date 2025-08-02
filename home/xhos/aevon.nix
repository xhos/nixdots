{pkgs, ...}: {
  imports = [
    ../../modules/home
  ];

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";

  modules = {
    secrets.enable = false;
  };
  
  default = {
    shell = "zsh";
    prompt = "starship";
  };
}
