{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.default.lock == "hyprlock") {
    programs.hyprlock = {
      enable = true;
      extraConfig = builtins.readFile ./hyprlock.conf;
    };
  };
}
