{ pkgs, config, ... }: {

environment.systemPackages = with pkgs; [
    # Networking
    nmap
    networkmanagerapplet
    wirelesstools # wireless stuff
    speedtest-cli
    blueman
    dig # dns lookup

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
    ffmpeg_5-full

    # Other      
    brightnessctl
    wayland

    rclone # to mount cloud storage
    
    git
    git-lfs
    git-extras

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
