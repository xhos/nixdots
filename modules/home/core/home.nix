{ config, inputs, lib, pkgs, pkgsStable, ... }: {
  home = {
    username = "xhos";
    homeDirectory = "/home/xhos";
    stateVersion = "24.05";
    file.".local/share/fonts".source = ./fonts;

    packages = with pkgs; [
      (pkgs.callPackage ../../../derivs/spotdl.nix { inherit (pkgs.python311Packages) buildPythonApplication; })
      (pkgs.callPackage ../../../home/shared/icons/whitesur.nix {})
      (pkgs.callPackage ../../../home/shared/icons/reversal.nix {})
      
      (pkgs.callPackage ../../../scripts/modeSwitcher.nix {})
      swww # wallpaper daemon
      protonvpn-gui 
      proton-pass
      kitty # here as a fallback
      gnome.nautilus
      (vscode.override { commandLineArgs = [ "--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];})
      (discord.override {withVencord = true;})
      obs-studio
      fastfetch
      termius # just for keychain accss
      hyprshot
      starship
      oh-my-posh
      wev # for keybindings 
      nushell
      fish grc
      scrcpy # android screen mirroring
      yazi # cli explorer

      # Dev
      rustup
      python3
      yq # YAML, JSON and XML processor
      alejandra # nix code formatter

      grim # screenshot util

      qbittorrent-qt5
      # rqbit
      # miru
      # stremio

      bemoji # emoji picker
      chromium
      circumflex # (clx) hacker news cli
      colordiff # file diff
      
      deadnix # remove unused code in nix files
      docker-compose
      feh # image viewer
      gcc
      gh # github cli
      gitmoji-cli # emoji for commits
      glab # gitlab cli
      glow # cli markdown renderer
      gnumake
      gum # fancy scripts
      imagemagick
      just # project specific commands
      marksman # markdown language server
      obsidian
      onefetch # git repo summary
      openssl
      openvpn
      pfetch-rs # system info
      playerctl # media controls
      rcon # remote console (minecraft?)
      sherlock
      skim # fzf in rust (sk)
      tailspin # log highlighter
      telegram-desktop
      tlrc # better man
      ventoy
      viddy # modern "watch"
      wireplumber # A modular session / policy manager for PipeWire
      xwayland
      zoxide # better cd
    ];
  };
}
