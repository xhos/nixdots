{ config, lib, ... }: {
  config = lib.mkIf config.hyprland.enable {
    services.displayManager.defaultSession = "Hyprland";
  };
}