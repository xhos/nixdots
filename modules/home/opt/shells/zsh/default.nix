{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./aliases.nix
    ./keybinds.nix
    ./options.nix
  ];

  config = lib.mkIf (config.default.shell == "zsh") {
    programs.zsh = {
      enable = true;
      plugins = [
        {
          name = "zsh-shift-select";
          src = pkgs.fetchFromGitHub {
            owner = "jirutka";
            repo = "zsh-shift-select";
            rev = "da460999b7d31aef0f0a82a3e749d70edf6f2ef9";
            sha256 = "sha256-ekA8acUgNT/t2SjSBGJs2Oko5EB7MvVUccC6uuTI/vc=";
          };
        }
      ];
    };
  };
}
