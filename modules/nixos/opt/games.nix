{
  pkgs,
  config,
  lib,
  ...
}: {
  options.games.enable = lib.mkEnableOption "gaming support (Steam, Prismlauncher)";

  config = lib.mkIf config.games.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher
    ];

    programs.steam.enable = true;
  };
}
