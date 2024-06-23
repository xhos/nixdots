{
  services = {
    # xserver = {
    #   enable = true;
    #   desktopManager.gnome.enable = false;
    # };

    displayManager = {
      defaultSession = "Hyprland";
    };

    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        middleEmulation = true;
        naturalScrolling = true;
      };
    };
  };
}
