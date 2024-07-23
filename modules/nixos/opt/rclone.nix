{ pkgs, config, lib, ... }: {
  config = lib.mkIf config.rclone.enable {
    systemd.services.rclone-gdrive-mount = {
      Unit = {
        Description = "Service that connects to OneDrive";
        After = [ "network-online.target" ];
        Requires = [ "network-online.target" ];
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
      
      Service = let
        onedriveDir = "/home/xhos/onedrive";
      in {
        Type = "simple";
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${onedriveDir}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full onedrive: ${onedriveDir}";
        ExecStop = "/run/current-system/sw/bin/fusermount -u ${onedriveDir}";
        Restart = "on-failure";
        RestartSec = "10s";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };
  };
}