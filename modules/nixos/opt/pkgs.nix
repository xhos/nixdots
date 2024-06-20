{
  pkgs,
  config,
  ...
}: { #TODO: this aint os pkgs
  environment.systemPackages = with pkgs; [
    swww
    nh
    protonvpn-gui
    nerdfonts
    fira-code-nerdfont
    kitty
    nmap
    gnome.nautilus
    networkmanagerapplet
    speedtest-cli
    lz4
    protonvpn-gui

    age
    bat
    blueman
    btop
    brightnessctl
    dig
    dosis
    ffmpeg_5-full
    fzf
    git
    git-extras
    gnu-config
    gnupg
    grim
    gtk3
    home-manager
    lua-language-server
    lua54Packages.lua
    mpv
    ncdu
    nix-prefetch-git
    nodejs
    obs-studio
    pamixer
    procps
    pulseaudio
    python3
    vscode
    ripgrep
    slop
    # spotify
    srt
    (lib.mkIf config.tailscale.enable tailscale)
    terraform-ls
    unzip
    (lib.mkIf config.wayland.enable wayland)
    wget
    wirelesstools
    xdg-utils
    yaml-language-server
    yq
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };
}
