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

    # GTNH opens *way too many* files
    # and theese are 3 ways to increase the limit
    # and i have no idea which one actually works :D
    boot.kernel.sysctl."fs.file-max" = 524288;
    systemd.user.extraConfig = ''
      DefaultLimitNOFILE=524288
    '';
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
