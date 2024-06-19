{
  config,
  inputs,
  lib,
  pkgs,
  pkgsStable,
  ...
}: {
  home = {
    username = "xhos";
    homeDirectory = "/home/xhos";
    stateVersion = "24.05";
    file.".local/share/fonts".source = ./fonts;
    activation = {
      installConfig = ''
        if [ ! -d "${config.home.homeDirectory}/.config/zsh" ]; then
          ${pkgs.git}/bin/git clone --depth 1 --branch zsh https://github.com/elythh/dotfiles ${config.home.homeDirectory}/.config/zsh
        fi
      '';
    };

    packages = with pkgs; [
      inputs.zjstatus.packages.${system}.default
      (pkgs.callPackage ../../../derivs/spotdl.nix {
        inherit (pkgs.python311Packages) buildPythonApplication;
      })
      (pkgs.callPackage ../../../home/shared/icons/whitesur.nix {})
      (pkgs.callPackage ../../../home/shared/icons/reversal.nix {})
      (lib.mkIf config.modules.rbw.enable rbw)
      (lib.mkIf config.modules.rbw.enable rofi-rbw)
      alejandra
      auth0-cli
      awscli
      bemoji
      charm
      charm-freeze
      chatterino2
      chromium
      circumflex
      clipse
      colordiff
      copyq
      deadnix
      docker-compose
      easyeffects
      eza
      feh
      fx
      fzf
      gcc
      gh
      git-lfs
      gitmoji-cli
      glab
      glow
      gnumake
      grimblast
      gum
      helmfile
      imagemagick
      inotify-tools
      jaq
      jq
      jqp
      just
      keybase
      light
      marksman
      networkmanagerapplet
      nh
      nix-inspect
      neovide
      obsidian
      onefetch
      openssl
      openvpn
      pavucontrol
      pfetch
      picom
      pinentry
      pkgsStable.go
      playerctl
      presenterm
      rcon
      rustup
      satty
      sherlock
      skopeo
      oras
      skim
      slack
      slides
      stern
      tailspin
      telegram-desktop
      tldr
      ventoy
      viddy
      wireplumber
      xdotool
      xwayland
      yarn
      zoxide
    ];
  };
}
