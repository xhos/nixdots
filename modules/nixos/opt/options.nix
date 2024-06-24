{lib, ...}: {
  options = {
    bluetooth.enable = lib.mkEnableOption "Enable bluetooth";
    wayland  .enable = lib.mkEnableOption "Enable wayland";
    audio    .enable = lib.mkEnableOption "Enable audio";
    fonts    .enable = lib.mkEnableOption "Enable fonts";
  };
}
