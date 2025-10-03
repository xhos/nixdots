{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];

  config = lib.mkIf (config.bar == "dankshell") {
    home.packages = with pkgs; [
      mate.mate-polkit
    ];

    programs.dankMaterialShell = {
      enable = true;
      enableSystemd = true;
    };

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "bash -c 'wl-paste --watch cliphist store &'"
        "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1"
      ];

      bind = [
        # "SUPER, Space, exec, dms ipc call spotlight toggle"
        # "SUPER, V, exec, dms ipc call clipboard toggle"
        "SUPER, M, exec, dms ipc call processlist toggle"
        # "SUPER, N, exec, dms ipc call notifications toggle"
        "SUPER, comma, exec, dms ipc call settings toggle"
        "SUPER, N, exec, dms ipc call notepad toggle"
        "SUPERALT, L, exec, dms ipc call lock lock"
        "SUPER, X, exec, dms ipc call powermenu toggle"
        # "SUPER, C, exec, dms ipc call control-center toggle"
        # "SUPERSHIFT, N, exec, dms ipc call night toggle"
      ];

      bindl = [
        ", XF86AudioRaiseVolume, exec, dms ipc call audio increment 3"
        ", XF86AudioLowerVolume, exec, dms ipc call audio decrement 3"
        ", XF86AudioMute, exec, dms ipc call audio mute"
        ", XF86AudioMicMute, exec, dms ipc call audio micmute"

        ", XF86MonBrightnessUp, exec, dms ipc call brightness increment 5 ''"
        ", XF86MonBrightnessDown, exec, dms ipc call brightness decrement 5 ''"
      ];
    };
  };
}
