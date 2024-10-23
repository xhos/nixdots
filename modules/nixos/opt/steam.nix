{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.steam.enable {
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        gamescopeSession.enable = true;
      };
      gamemode.enable = true;
    };

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/xhos/.steam/root/.compatibilitytools.d";
    };

    environment.systemPackages = with pkgs; [protonup];
  };
}
