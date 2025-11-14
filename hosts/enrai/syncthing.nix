{
  config,
  pkgs,
  ...
}: {
  sops.secrets = {
    "syncthing/cert" = {
      owner = config.services.syncthing.user;
      mode = "0400";
    };
    "syncthing/key" = {
      owner = config.services.syncthing.user;
      mode = "0400";
    };
    "syncthing/guiPassword" = {
      owner = config.services.syncthing.user;
      mode = "0400";
    };
  };

  services.syncthing = {
    enable = true;
    user = "xhos";
    dataDir = "/home/xhos/syncthing";
    key = config.sops.secrets."syncthing/key".path;
    cert = config.sops.secrets."syncthing/cert".path;

    # TODO: yet to be released
    # guiPasswordFile = config.sops.secrets."syncthing/guiPassword".path;

    settings = {
      options.urAccepted = -1;
      gui = {
        user = "xhos";
        password = "$2b$12$mXEJ2ZnOFfk9VvANdQKjdOvRHqeBFxT6h0BF1EavsThTGQADZAiHK";
      };

      # device id can be found in client's ui
      devices."pixel".id = "JYTSP44-WEDIVSO-O7P3QAI-VARARVP-KT6GK2A-JV2XADQ-GJDTF6Q-Z4Q6YAN";

      folders = {
        "notes" = {
          path = "/home/xhos/Documents/notes";
          devices = ["pixel"];
        };
      };
    };
  };

  systemd.services.notes-git-sync = {
    description = "sync notes with git";
    path = [ pkgs.git pkgs.openssh ];
    serviceConfig = {
      Type = "oneshot";
      User = "xhos";
      WorkingDirectory = "/home/xhos/Documents/notes";
      ExecStart = pkgs.writeShellScript "sync-notes" ''
        set -e

        git pull --rebase --autostash || {
          git rebase --abort 2>/dev/null || true
          git pull --no-rebase --autostash
        }

        git add -A
        git commit -m "auto-sync from enrai $(date '+%Y-%m-%d %H:%M')" || true

        git push
      '';
    };
  };

  systemd.timers.notes-git-sync = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "*:0/15";
      Persistent = true;
    };
  };
}
