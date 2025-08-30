{
  config,
  lib,
  pkgs,
  ...
}: let
  # CLI packages useful on both headless and desktop systems
  cliPkgs = with pkgs; [
    # Networking tools
    nmap
    speedtest-cli
    dig # dns lookup
    openssl
    wirelesstools # wireless utilities (useful for headless WiFi setup too)

    # Hardware monitoring
    lm_sensors
    fan2go

    # Nix ecosystem tools
    npins
    nh # nix helper
    home-manager
    nix-prefetch-git
    nix-inspect

    # Version control
    git
    git-lfs
    git-extras

    # Security & secrets
    age # file encryption
    sops # secrets encryption

    # CLI utilities
    bat # cat but better
    btop
    fzf
    procps # process info
    ncdu # disk usage
    ripgrep # recursively searches directories for regex patterns
    wget
    unzip
    neovim
  ];

  # GUI packages for desktop systems only
  guiPkgs = with pkgs; [
    # GUI networking
    networkmanagerapplet

    # Audio GUI controls
    pavucontrol # pulseaudio/pipewire controls
    easyeffects # pipewire audio effects

    # Desktop utilities
    brightnessctl # screen brightness control
    xterm # GUI terminal
    xdg-utils # desktop integration utilities
    gtk3 # GUI toolkit
  ];
in {
  environment.systemPackages = lib.concatLists [
    cliPkgs
    (lib.optionals (config.headless != true) guiPkgs)
  ];

  nixpkgs.config.allowUnfree = true;
}
