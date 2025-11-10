{config, ...}: {
  sops.secrets."env/wled-album-sync" = {};

  services.wled-album-sync = {
    enable = true;
    wledUrl = "http://10.0.0.85";
    port = 9123;

    homeAssistant = {
      url = "http://10.0.0.10:8123";
      entity = "media_player.yandex_station_xk0000000000000286720000e2296918";
    };

    spotify.clientId = "27bab5ed9bd8438a801980f52ba273ce";

    envFile = config.sops.secrets."env/wled-album-sync".path;
  };
}
# evaluation warning: getExe: Package "wled-album-sync-0.1.0" does not have the meta.mainProgram attribute. We'll assume that the main program has the same name for now, but this behavior is deprecated, because it leads to surprising errors when the assumption does not hold. If the package has a main program, please set `meta.mainProgram` in its definition to make this warning go away. Otherwise, if the package does not have a main program, or if you don't control its definition, use getExe' to specify the name to the program, such as lib.getExe' foo "bar".
# evaluation warning: wled-album-sync.service is ordered after 'network-online.target' but doesn't depend on it

