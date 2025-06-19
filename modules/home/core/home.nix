# modules/home-pkgs.nix
{
  inputs,
  pkgs,
  lib,
  system,
  config,
  ...
}: let
  corePkgs = with pkgs; [
    firefox
    font-manager
    nil # nix lsp
    delve
    rnote
    fd
    egl-wayland # needed for a firefox fix
    gdb
    wayvnc
    lazygit
    cling
    wvkbd # on-screen keyboard
    figlet # cool text gen
    nwg-displays

    # cli
    fastfetch
    hyprshot
    wev # for keybindings
    scrcpy # android screen mirroring
    yazi # cli explorer
    colordiff # file diff
    lz4
    swayimg # image viewer
    gitmoji-cli # emoji for commits
    glow # cli markdown renderer
    imagemagick
    onefetch # git repo summary
    openvpn
    pfetch-rs # system info
    playerctl # media controls
    rcon # remote console
    sherlock
    skim # fzf in rust
    devenv
    sshs

    # shells & prompts
    starship
    oh-my-posh
    nushell
    fish
    zsh
    grc
    wireplumber # PipeWire session manager

    # Dev
    rustup
    python3
    alejandra # nix code formatter
    nixd
    docker-compose
    gcc
    gh # GitHub CLI
    viddy # modern "watch"
    gnumake
    gum # fancy scripts
    tlrc # better man
    dialog
    freerdp3
    iproute2
    libnotify
    netcat-gnu
    loupe
    jq
  ];

  optionalPkgs = with pkgs; [
    # heavy GUI / multimedia / browsers
    krita
    libreoffice
    postman
    gnome-solanum
    xournalpp
    inputs.zen-browser.packages."${system}".default
    mpv # video player
    ffmpeg-full
    protonvpn-gui
    proton-pass
    kitty # fallback terminal
    nautilus
    qbittorrent
    (obsidian.override {commandLineArgs = ["--no-sandbox"];})
    chromium
    telegram-desktop
  ];
in {
  home = {
    username = "xhos";
    homeDirectory = "/home/xhos";
    stateVersion = "25.05";

    packages =
      lib.concatLists
      [
        corePkgs
        (
          if config.optPkgs.enable
          then optionalPkgs
          else []
        )
      ];
  };
}
