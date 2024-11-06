{lib, ...}: {
  options = {
    bluetooth.enable = lib.mkEnableOption "Enable bluetooth";
    rclone   .enable = lib.mkEnableOption "Enable rclone";
    wayland  .enable = lib.mkEnableOption "Enable wayland";
    audio    .enable = lib.mkEnableOption "Enable audio";
    sops    .enable = lib.mkEnableOption "Enable sops";
    steam    .enable = lib.mkEnableOption "Enable steam";
    sshserver.enable = lib.mkEnableOption "Enable ssh server";
    greetd.enable = lib.mkEnableOption "Enable greetd";
    hyprland.enable = lib.mkEnableOption "Enable hyprland";
    xserver.enable = lib.mkEnableOption "Enable xserver";
  };
}
