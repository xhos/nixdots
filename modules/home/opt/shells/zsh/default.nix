{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./aliases.nix
  ];

  config = lib.mkIf (config.default.shell == "zsh") {
    programs.zsh = {
      enable = true;
      plugins = [
        {
          name = pkgs.zsh-autosuggestions.pname;
          src = pkgs.zsh-autosuggestions.src;
        }
        {
          name = pkgs.zsh-syntax-highlighting.pname;
          src = pkgs.zsh-syntax-highlighting.src;
        }
      ];
    };
  };
}
