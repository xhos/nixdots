{
  pkgs,
  config,
  ...
}: { #TODO: this aint os pkgs
  environment.systemPackages = with pkgs; [
    # no gui applications are supposed to be here
    # the logic is that this is what might be installed on a headless machine
    nmap
    networkmanagerapplet
    speedtest-cli
    nh
    rustup
    git-lfs

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
    pamixer
    procps
    pulseaudio
    python3
    ripgrep
    slop
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
