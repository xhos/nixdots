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

      envExtra = ''
        bindkey '^[[1;5D' backward-word
        bindkey '^[[1;5C' forward-word
        bindkey -s '^[[1;2D' '^[b'  # Shift + Left Arrow to select the word to the left
        bindkey -s '^[[1;2C' '^[f'  # Shift + Right Arrow to select the word to the right
      '';
    };
  };
}
