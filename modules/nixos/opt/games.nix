{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.games.enable {
    environment.systemPackages = with pkgs; [
      # r2modman
      # lutris
      prismlauncher
    ];

    programs.steam.enable = true;
  };
}
