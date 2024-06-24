{lib, ...}: {
  options = {
    bluetooth.enable = lib.mkEnableOption "Enable bluetooth";
    wayland  .enable = lib.mkEnableOption "Enable wayland";
    sound    .enable = lib.mkEnableOption "Enable sound";
    fonts    .enable = lib.mkEnableOption "Enable fonts";
    steam    .enable = lib.mkEnableOption "Enable steam";
  };
}
