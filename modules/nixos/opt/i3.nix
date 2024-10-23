{ config, lib, ... }: {
  config = lib.mkIf config.i3.enable {
    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };
    # services.displayManager = {
    #   defaultSession = "none+i3";
    #     enable = true;
    #     greeter.enable = false;
    #     autoLogin = {
    #       enable = true;
    #       user = "xhos";
    #     };
    #   };
    # };
  };
}
