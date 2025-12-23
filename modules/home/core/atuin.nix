{config, ...}: {
  sops.secrets."api/atuin/key".path = "${config.home.homeDirectory}/.local/share/atuin/key";
  sops.secrets."api/atuin/session".path = "${config.home.homeDirectory}/.local/share/atuin/session";

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings.sync_address = "https://atuin.xhos.dev";
  };
}
