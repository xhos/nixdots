{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf (config.greeter == "sddm") {
    services.displayManager = {
      defaultSession = "hyprland";
      sessionPackages = [pkgs.hyprland];
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "catppuccin-mocha-mauve";
      };
    };

    environment.systemPackages = [
      (pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        accent = "mauve";
      })
    ];
  };
}
