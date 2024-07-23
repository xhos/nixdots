{lib, ...}: {
  options = {
    bluetooth.enable = lib.mkEnableOption "Enable bluetooth";
    rclome   .enable = lib.mkEnableOption "Enable rclome";
    wayland  .enable = lib.mkEnableOption "Enable wayland";
    audio    .enable = lib.mkEnableOption "Enable audio";
    fonts    .enable = lib.mkEnableOption "Enable fonts";
    sshserver.enable = lib.mkEnableOption "Enable ssh server";
  };
}
