{lib, ...}: {
  options = with lib; {
    bluetooth.enable = mkEnableOption "Enable bluetooth";
    rclone   .enable = mkEnableOption "Enable rclone";
    wayland  .enable = mkEnableOption "Enable wayland";
    audio    .enable = mkEnableOption "Enable audio";
    sops     .enable = mkEnableOption "Enable sops";
    steam    .enable = mkEnableOption "Enable steam";
    sshserver.enable = mkEnableOption "Enable ssh server";
    greetd   .enable = mkEnableOption "Enable greetd";
    nvidia   .enable = mkEnableOption "Enable nvidia support";
    vm       .enable = mkEnableOption "Enable vm support";
    ai       .enable = mkEnableOption "Enable ai support";
    obs      .enable = mkEnableOption "Enable obs support";

    de = mkOption {
      type = types.enum ["hyprland" "gnome" "cosmic" "plasma" "xfce" "none"];
      default = "none";
    };

    greeter = mkOption {
      type = types.enum ["regreet" "tuigreet" "none"];
      default = "none";
    };
  };
}
