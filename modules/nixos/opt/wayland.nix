{ pkgs, config, lib, ... }: {
  config = lib.mkIf config.wayland.enable {
    environment.systemPackages = with pkgs; [
      xwayland
      wayland
    ];
    xdg.portal.wlr.enable = true; # enable desktop portal for wlroots-based desktops.
  };
}