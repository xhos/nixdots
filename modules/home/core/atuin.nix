{config, ...}: {
  sops.secrets."api/atuin/key".path = "${config.home.homeDirectory}/.local/share/atuin/key";
  sops.secrets."api/atuin/session".path = "${config.home.homeDirectory}/.local/share/atuin/session";

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      sync_address = "https://atuin.xhos.dev";
      enter_accept = true;
      update_check = false;
      filter_mode_shell_up_key_binding = "session";
      inline_height = 10;
      invert = true;
      show_help = false;
    };
    flags = ["--disable-up-arrow"];
  };

  programs.zsh.initContent = ''bindkey "$key[Down]"  atuin-up-search'';
}
