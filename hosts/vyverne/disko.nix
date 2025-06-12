{
  disko.devices.disk.main = {
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

        nix = {
          size = "100G";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/nix";
          };
        };

        persist = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/persist";
          };
        };
      };
    };
  };
}
