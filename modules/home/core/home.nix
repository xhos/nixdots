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

    packages = with pkgs; [
      # TODO move cli tools to nixos module (those not home manager managed)
      (pkgs.callPackage ../../../derivs/spotdl.nix { inherit (pkgs.python311Packages) buildPythonApplication; })
      (pkgs.callPackage ../../../home/shared/icons/whitesur.nix {})
      (pkgs.callPackage ../../../home/shared/icons/reversal.nix {})
      alejandra
      swww 
      protonvpn-gui
      kitty
      gnome.nautilus
      vscode
      obs-studio
      fastfetch

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
      gcc
      gh
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
      satty
      sherlock
      skopeo
      oras
      skim
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
