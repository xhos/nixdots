{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  config = lib.mkIf (config.default.bar == "astal") {
    home.packages = with pkgs; [
      inputs.astal-shell.packages.${system}.default
    ];

    wayland.windowManager.hyprland.settings = {
      exec = ["my-shell"];
    };
  };
}
