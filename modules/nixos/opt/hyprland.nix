{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.hyprland.enable {
    # programs.hyprland.enable = true;
    services.displayManager.defaultSession = "Hyprland";
  };
}
