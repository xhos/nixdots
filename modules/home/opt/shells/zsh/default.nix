{
  config,
  lib,
  ...
}: {
  imports = [
    ./run-as-service.nix
    ./aliases.nix
    ./keybinds.nix
    ./options.nix
  ];

  config = lib.mkIf (config.default.shell == "zsh") {
    programs.zsh = {
      enable = true;
    };
  };
}
