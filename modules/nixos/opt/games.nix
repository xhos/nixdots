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

    # GTNH was opens *way too many* files
    boot.kernel.sysctl."fs.file-max" = 524288;
    security.pam.loginLimits = [
      {
        domain = "*";
        type = "soft";
        item = "nofile";
        value = "65536";
      }
      {
        domain = "*";
        type = "hard";
        item = "nofile";
        value = "524288";
      }
    ];
  };
}
