{lib, ...}: {
  options = {
    bluetooth.enable = lib.mkEnableOption "Enable bluetooth";
    rclone   .enable = lib.mkEnableOption "Enable rclone";
    wayland  .enable = lib.mkEnableOption "Enable wayland";
    audio    .enable = lib.mkEnableOption "Enable audio";
    fonts    .enable = lib.mkEnableOption "Enable fonts";
    sshserver.enable = lib.mkEnableOption "Enable ssh server";
  };
}
