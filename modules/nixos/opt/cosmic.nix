{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.de == "cosmic") {
    # environment.systemPackages = [
    # ];

    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
  };
}
