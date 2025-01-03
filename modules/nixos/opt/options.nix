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

    de = mkOption {
      type = types.enum ["hyprland" "gnome" "plasma" "none"];
      default = "none";
    };

    greeter = mkOption {
      type = types.enum ["regreet" "tuigreet" "none"];
      default = "none";
    };
  };
}
