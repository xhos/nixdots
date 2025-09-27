{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.greeter == "autologin") {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user = "xhos";
        };
        default_session = initial_session;
      };
    };
  };
}
