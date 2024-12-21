{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.default.de == "hyprland") {
    services.xserver.enable = true;
    programs.hyprland.enable = true;
    services.displayManager.defaultSession = "hyprland";
  };
}
