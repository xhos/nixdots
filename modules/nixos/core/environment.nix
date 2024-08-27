{ pkgs, config, ... }: {
  environment = {
    shells = with pkgs; [nushell zsh fish];
    variables.FLAKE = "/etc/nixos"; # path to this config
    variables.EDITOR = "zed";
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/xhos/.steam/root/.compatibilitytools.d";
    };
  };
}
