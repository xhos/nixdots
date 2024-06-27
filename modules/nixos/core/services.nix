{ lib, pkgs, config, inputs, ... }: {
  config.services = {
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        middleEmulation = true;
        naturalScrolling = true;
      };
    };
  
    dbus.enable = true;
    upower.enable = true;

    logind = {
      powerKey = "suspend";
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
    };

    xserver.enable = true;

    xserver.xkb = {
      layout = "us";
      options = "compose:rctrl,caps:escape";
    };

    gnome = {
      gnome-keyring.enable = true;
      glib-networking.enable = true;
    };
  };
}
