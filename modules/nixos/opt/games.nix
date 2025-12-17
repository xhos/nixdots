{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.games.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher
    ];

    programs.steam.enable = true;
  };
}
