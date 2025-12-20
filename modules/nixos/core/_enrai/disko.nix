{
  disk ? "/dev/sda",
  dataDisk ? "/dev/sdb",
  ...
}: {
  disko.devices = {
    # System drive
    disk.system = {
      type = "disk";
      device = disk;
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
          system-zpool = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "system";
            };
          };
        };
      };
    };

    # Data drive
    disk.data = {
      type = "disk";
      device = dataDisk;
      content = {
        type = "gpt";
        partitions = {
          data-zpool = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "storage";
            };
          };
        };
      };
    };

    zpool = {
      # System pool
      system = {
        type = "zpool";
        rootFsOptions = {
          compression = "zstd";
          atime = "off";
          normalization = "formD";
          xattr = "sa";
          acltype = "posixacl";
          mountpoint = "none";
        };
        datasets = {
          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          "safe/state" = {
            type = "zfs_fs";
            mountpoint = "/persist";
          };
        };
      };

      # Storage pool
      storage = {
        type = "zpool";
        rootFsOptions = {
          compression = "zstd";
          atime = "off";
          normalization = "formD";
          xattr = "sa";
          acltype = "posixacl";
          mountpoint = "none";
        };
        datasets = {
          "data/photos" = {
            type = "zfs_fs";
            mountpoint = "/storage/photos";
          };
          "data/media" = {
            type = "zfs_fs";
            mountpoint = "/storage/media";
          };
          "data/other" = {
            type = "zfs_fs";
            mountpoint = "/storage/other";
          };
        };
      };
    };
  };
}
