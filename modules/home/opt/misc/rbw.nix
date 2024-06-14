{
  config,
  lib,
  ...
}:
lib.mkIf config.modules.rbw.enable {
  home.file.".config/rbw/config.json".text = ''
    {
      "email":"xxhos@pm.me",
      "base_url":"https://bitwarden.elyth.xyz",
      "identity_url":null,
      "notifications_url":null,
      "lock_timeout":99999999999999999,
      "sync_interval":3600,
      "pinentry":"pinentry",
      "client_cert_path":null
    }
  '';
}
