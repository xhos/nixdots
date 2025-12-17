{
  config,
  lib,
  ...
}: {
  options.syncthing.enable = lib.mkEnableOption "sync obsidian notes via syncthing";

  config = lib.mkIf config.syncthing.enable {
    sops.secrets = {
      "syncthing/${config.networking.hostName}/cert".mode = "0400";
      "syncthing/${config.networking.hostName}/key".mode = "0400";
    };

    services.syncthing = {
      enable = true;
      user = "xhos";
      group = "users";
      dataDir = "/home/xhos/.local/share/syncthing";
      configDir = "/home/xhos/.config/syncthing";

      cert = config.sops.secrets."syncthing/${config.networking.hostName}/cert".path;
      key = config.sops.secrets."syncthing/${config.networking.hostName}/key".path;

      settings = {
        options.urAccepted = -1;
        devices."enrai".id = "VOGYGVF-P53JZY4-C2Q5ITL-VVFV34S-XKCUQTT-3D7BRXM-WGO2C3J-ODKARQT";

        folders."notes" = {
          path = "/home/xhos/Documents/notes";
          devices = ["enrai"];
        };
      };

      openDefaultPorts = true;
    };
  };
}
