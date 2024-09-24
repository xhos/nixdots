{ pkgs, config, lib, ... }: {
  config = lib.mkIf config.rclone.enable {
    environment.systemPackages = with pkgs; [ rclone ];
    systemd.services.rclone-onedrive-mount = {
      wantedBy = [ "default.target" ];
      after    = [ "network-online.target" ];
      requires = [ "network-online.target" ];
    
      serviceConfig = let
        onedriveDir = "/home/xhos/onedrive";
      in {
        Type = "simple";
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${onedriveDir}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full onedrive: ${onedriveDir}";
        ExecStop = "/run/current-system/sw/bin/fusermount -u ${onedriveDir}";
        Restart = "on-failure";
        RestartSec = "10s";
        User = "xhos";
        Group = "users";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };
  };
}