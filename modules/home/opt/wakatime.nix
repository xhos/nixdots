{ config, ... }:
let
  secret_path = "api/wakapi";
  file = ".wakatime.cfg";
in
{
  sops = {
    secrets.${secret_path} = { };
    templates.${file} = {
      content = ''
        [settings]
        api_url = https://wakapi.xhos.dev/api
        api_key = ${config.sops.placeholder.${secret_path}}
      '';
      path = "${config.xdg.configHome}/wakatime/${file}";
    };
  };
}
