{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./binds.nix
    ./options.nix
    ./rules.nix
    ./hyprspace.nix
    ./pkgs.nix
  ];

  config = lib.mkIf (config.default.de == "hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;
      plugins = with pkgs.hyprlandPlugins; [
        hyprgrass
        hypr-dynamic-cursors
      ];

      xwayland.enable = true;
      # systemd = {
      #   enable = true;
      #   extraCommands = lib.mkBefore [
      #     "systemctl --user stop graphical-session.target"
      #     "systemctl --user start hyprland-session.target"
      #   ];
      # };
    };

    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = ["graphical-session-pre.target"];
      };
    };
  };
}
