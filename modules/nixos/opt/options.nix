{lib, ...}: {
  options = with lib; {
    impermanence.enable = mkEnableOption "nuke da pc";
    bluetooth.enable = mkEnableOption "Enable bluetooth";
    rclone   .enable = mkEnableOption "Enable rclone";
    wayland  .enable = mkEnableOption "Enable wayland";
    audio    .enable = mkEnableOption "Enable audio";
    sops     .enable = mkEnableOption "Enable sops";
    steam    .enable = mkEnableOption "Enable steam";
    greetd   .enable = mkEnableOption "Enable greetd";
    nvidia   .enable = mkEnableOption "Enable nvidia support";
    vm       .enable = mkEnableOption "Enable vm support";
    ai       .enable = mkEnableOption "Enable ai support";
    boot      .enable = mkEnableOption "Enable boot support";
    headless = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "disable all gui related stuff";
    };

    greeter = mkOption {
      type = types.enum ["regreet" "tuigreet" "ly" "sddm" "none"];
      default = "none";
    };
  };
}
