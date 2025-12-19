{
  config,
  lib,
  ...
}: {
  options.greetd.enable = lib.mkEnableOption "greetd display manager (use greeter option to select which greeter)";

  # The actual greeter configuration is in the greeters/ subdirectory
  # This module just provides the enable option
  config = lib.mkIf config.greetd.enable {};
}
