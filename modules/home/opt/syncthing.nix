{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.syncthing.enable {
    services.syncthing = {
      enable = true;

      settings = {
        devices."enrai".id = "VOGYGVF-P53JZY4-C2Q5ITL-VVFV34S-XKCUQTT-3D7BRXM-WGO2C3J-ODKARQT";

        folders."notes" = {
          path = "~/Documents/notes";
          devices = ["enrai"];
        };
      };
    };
  };
}
