{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            zpool = {
              size = "100%";
              content = {
                type = "zfs"; # just point at the pool name
                pool = "rpool";
              };
            };
          };
        };
      };
    };

    # Top‐level ZFS pool + datasets
    zpool = {
      rpool = {
        type = "zpool";
        # inherited defaults (compression, acltype, etc.) can be set here
        rootFsOptions = {
          compression = "zstd";
          atime = "off";
          normalization = "formD";
          xattr = "sa";
          acltype = "posixacl";
          mountpoint = "none";
        };
        datasets = {
          # child datasets get mounted later by NixOS/systemd-fstab
          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          "safe/state" = {
            type = "zfs_fs";
            mountpoint = "/persist";
          };
          "safe/games" = {
            type = "zfs_fs";
            mountpoint = "/persist/games";
          };
        };
      };
    };
  };
}
