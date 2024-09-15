{ lib, ... }: {
  options = {
    bluetooth.enable = lib.mkEnableOption "Enable bluetooth";
    rclone   .enable = lib.mkEnableOption "Enable rclone";
    wayland  .enable = lib.mkEnableOption "Enable wayland";
    audio    .enable = lib.mkEnableOption "Enable audio";
    fonts    .enable = lib.mkEnableOption "Enable fonts";
    sops    .enable = lib.mkEnableOption "Enable sops";
    steam    .enable = lib.mkEnableOption "Enable steam";
    sshserver.enable = lib.mkEnableOption "Enable ssh server";
    boot-management.enable = lib.mkEnableOption "Enable boot managment";
  };
}
