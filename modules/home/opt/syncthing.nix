{
  config,
  lib,
  osConfig,
  ...
}: {
  sops.secrets = lib.mkIf config.modules.syncthing.enable {
    "syncthing/${osConfig.networking.hostName}/cert".mode = "0400";
    "syncthing/${osConfig.networking.hostName}/key".mode = "0400";
  };

  services.syncthing = lib.mkIf config.modules.syncthing.enable {
    enable = true;

    cert = config.sops.secrets."syncthing/${osConfig.networking.hostName}/cert".path;
    key = config.sops.secrets."syncthing/${osConfig.networking.hostName}/key".path;

    settings = {
      options.urAccepted = -1;
      devices."enrai".id = "VOGYGVF-P53JZY4-C2Q5ITL-VVFV34S-XKCUQTT-3D7BRXM-WGO2C3J-ODKARQT";

      folders."notes" = {
        path = "~/Documents/notes";
        devices = ["enrai"];
      };
    };
  };
}
