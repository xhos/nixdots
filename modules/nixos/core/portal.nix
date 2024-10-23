{ pkgs, ... }: {
    xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    configPackages = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        # xdg-desktop-portal-wlr
    ];
    # config.common.default = "*";
    };
}
