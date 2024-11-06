{
  pkgs,
  config,
  ...
}: {
  services.xserver.enable = true;

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    # Networking
    nmap
    networkmanagerapplet
    wirelesstools # wireless stuff
    speedtest-cli
    blueman
    dig # dns lookup
    gpclient

    lm_sensors
    fan2go

    # Nix related
    nh # nix helper
    home-manager
    nix-prefetch-git
    nix-inspect

    # Audio
    pulseaudio
    pamixer # pulseaudio command line mixer
    pavucontrol # pulseaudio controls
    easyeffects # pipewire audio effects

    # Video
    mpv # video player
    ffmpeg-full

    # Other
    brightnessctl

    git
    git-lfs
    git-extras
    xterm

    age # file encryption
    sops # secrets encryption

    bat # cat but better
    btop
    fzf
    procps # process info
    ncdu # disk usage
    ripgrep # recursively searches the current directory for a regex pattern
    wget
    xdg-utils # idk some utils
    unzip
    gtk3
    neovim
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };
}
