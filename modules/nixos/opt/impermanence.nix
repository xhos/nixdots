{
  lib,
  config,
  ...
}: let
  persistIf = condition: persistConfig: lib.mkIf condition persistConfig;

  userDir = path: {
    directory = "/home/xhos/${path}";
    user = "xhos";
    group = "users";
    mode = "0755";
  };
in {
  config = lib.mkIf config.impermanence.enable {
    programs.fuse.userAllowOther = true;

    environment.persistence."/persist" = lib.mkMerge [
      {
        hideMounts = true;
        directories = [
          "/etc/nixos"
          "/etc/ssh"
          "/var/lib/nixos"
          "/etc/NetworkManager/system-connections"
          "/var/lib/fprint"
        ];
        files = [
          "/etc/machine-id"
        ];
      }

      (persistIf config.bluetooth.enable {
        directories = [
          "/var/lib/bluetooth"
        ];
      })

      (persistIf config.vm.enable {
        directories = [
          "/var/lib/libvirt"
        ];
      })

      (persistIf config.ai.enable {
        directories = [
          "/var/lib/private/ollama"
        ];
      })

      (persistIf config.steam.enable {
        directories = [
          (userDir ".steam")
          (userDir ".local/share/Steam")
        ];
      })

      (persistIf config.rclone.enable {
        directories = [
          "/home/xhos/onedrive"
          "/home/xhos/protondrive"
        ];
      })

      (persistIf (config.greetd.enable && config.greeter == "tuigreet") {
        files = [
          "/var/cache/tuigreet/lastuser"
        ];
      })

      (persistIf config.headless {
        directories = [
          "/var/lib/jellyfin"
          "/var/lib/bazarr"
          "/var/lib/sonarr"
          "/var/cache/jellyfin"
          "/var/lib/private/prowlarr"
          "/var/lib/qBittorrent"
          "/var/lib/incus"
        ];
      })
    ];

    fileSystems."/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["defaults" "size=25%" "mode=755"];
    };

    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persist".neededForBoot = true;
  };
}
