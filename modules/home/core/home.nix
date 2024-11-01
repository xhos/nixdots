{
  inputs,
  pkgs,
  pkgsStable,
  ...
}: {
  home = {
    username = "xhos";
    homeDirectory = "/home/xhos";
    stateVersion = "24.05";

    packages = with pkgs; [
      # (pkgs.callPackage ../../../derivs/spotdl.nix { inherit (pkgs.python311Packages) buildPythonApplication; })
      # (pkgs.callPackage ../../../home/shared/icons/whitesur.nix {})
      # (pkgs.callPackage ../../../home/shared/icons/reversal.nix {})
      inputs.swww.packages.${pkgs.system}.swww
      # inputs.winapps.packages.${pkgs.system}.winapps
      egl-wayland # needed for a firefox fix
      wayvnc
      # lunarvim
      # httrack # offline websites
      lazygit
      teams-for-linux
      # inputs.nixvim.packages.${pkgs.system}.default
      thefuck
      wvkbd #osk
      figlet # cool text gen
      nwg-displays
      # alacritty
      xwaylandvideobridge # for screen sharing
      # Utils
      # swww # wallpaper daemon
      fastfetch
      hyprshot
      wev # for keybindings
      scrcpy # android screen mirroring
      yazi # cli explorer
      colordiff # file diff
      lz4
      clipse # clipboard manager
      swayimg # image viewer
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
      sshs
      # Actual software
      zed-editor
      protonvpn-gui
      proton-pass
      kitty # here as a fallback
      quickemu
      nautilus
      bottles # run windows
      obs-studio
      termius
      qbittorrent
      obsidian
      chromium
      telegram-desktop
      # rqbit
      # miru
      # stremio

      mako
      libnotify
      # TODO: ?Should not be here?
      starship
      oh-my-posh
      nushell
      fish
      zsh
      grc
      wireplumber # A modular session / policy manager for PipeWire
      # xwayland

      # Dev
      rustup
      python3
      # yq # YAML, JSON and XML processor
      alejandra # nix code formatter
      nixd
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
      # miraclecast
      dialog
      freerdp3
      iproute2
      libnotify
      netcat-gnu
    ];
  };
}
