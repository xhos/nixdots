{
  imports = [
    ./home.nix
    ./nixpkgs.nix
    ./options.nix
    ./programs.nix
    ./ssh.nix
  ];

  programs.home-manager.enable = true;
}
