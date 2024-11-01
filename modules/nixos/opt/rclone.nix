{
  pkgs,
  config,
  lib,
  ...
}:
# the rclone remote drives must be configured via 'rclone config' by hand
# see https://rclone.org/docs/
let
  # theese need to be created manually
  onedriveDir = "/home/xhos/onedrive";
  protondriveDir = "/home/xhos/protondrive";

  # the user that will run the service
  username = "xhos";
in {
  config = lib.mkIf config.rclone.enable {
    environment.systemPackages = with pkgs; [rclone];

    systemd.services = {
      rclone-onedrive-mount = {
        wantedBy = ["default.target"];
        after = ["network-online.target"];
        requires = ["network-online.target"];

        serviceConfig = {
          Type = "simple";
          ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${onedriveDir}";
          ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full onedrive: ${onedriveDir}";
          ExecStop = "/run/current-system/sw/bin/fusermount -u ${onedriveDir}";
          Restart = "on-failure";
          RestartSec = "10s";
          User = username;
          Group = "users";
          Environment = ["PATH=/run/wrappers/bin/:$PATH"];
        };
      };

      rclone-protondrive-mount = {
        wantedBy = ["default.target"];
        after = ["network-online.target"];
        requires = ["network-online.target"];

        serviceConfig = {
          Type = "simple";
          ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${protondriveDir}";
          ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full protondrive: ${protondriveDir}";
          ExecStop = "/run/current-system/sw/bin/fusermount -u ${protondriveDir}";
          Restart = "on-failure";
          RestartSec = "10s";
          User = username;
          Group = "users";
          Environment = ["PATH=/run/wrappers/bin/:$PATH"];
        };
      };
    };
  };
}
