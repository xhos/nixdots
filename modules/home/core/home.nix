{ config, inputs, lib, pkgs, pkgsStable, ... }: {
  home = {
    username = "xhos";
    homeDirectory = "/home/xhos";
    stateVersion = "24.05";

    packages = with pkgs; [
      # (pkgs.callPackage ../../../derivs/spotdl.nix { inherit (pkgs.python311Packages) buildPythonApplication; })
      # (pkgs.callPackage ../../../home/shared/icons/whitesur.nix {})
      # (pkgs.callPackage ../../../home/shared/icons/reversal.nix {})
      egl-wayland # needed for a firefox fix
      wayvnc
      thefuck
      wvkbd #osk
      figlet # cool text gen
      nwg-displays
      alacritty
      xwaylandvideobridge # for screen sharing
      # Utils
      swww # wallpaper daemon
      fastfetch
      hyprshot
      wev # for keybindings
      scrcpy # android screen mirroring
      yazi # cli explorer
      colordiff # file diff
      clipse # clipboard manager
      feh # image viewer
      gitmoji-cli # emoji for commits
      glab # gitlab cli
      glow # cli markdown renderer
      imagemagick
      onefetch # git repo summary
      openssl
      openvpn
      pfetch-rs # system info
      playerctl # media controls
      rcon # remote console (minecraft?)
      sherlock
      skim # fzf in rust (sk)
      zoxide # better cd
      tailspin # log highlighter
      devenv
      # Actual software
      zed-editor
      protonvpn-gui
      proton-pass
      kitty # here as a fallback
      nautilus
      bottles # run windows
      (vscode.override { commandLineArgs = [ "--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];})
      obs-studio
      # termius # just for keychain accss
      qbittorrent-qt5
      obsidian
      chromium
      telegram-desktop
      # rqbit
      # miru
      # stremio

      # TODO: ?Should not be here?
      starship
      oh-my-posh
      nushell
      fish grc
      wireplumber # A modular session / policy manager for PipeWire
      # xwayland

      # Dev
      rustup
      python3
      # yq # YAML, JSON and XML processor
      # alejandra # nix code formatter
      # deadnix # remove unused code in nix files
      docker-compose
      gcc
      gh # github cli
      # marksman # markdown language server
      # just # project specific commands
      viddy # modern "watch"
      gnumake
      gum # fancy scripts

      bemoji # emoji picker
      # circumflex # (clx) hacker news cli


      tlrc # better man
      ventoy
      # gnome-network-displays # not implemented yet: https://github.com/hyprwm/xdg-desktop-portal-hyprland/issues/70
      miraclecast

    ];
  };
}
