{
  imports = [
    ./home.nix
    ./nixpkgs.nix
    ./options.nix
    ./direnv.nix
    ./ssh.nix
    ./zellij.nix
    ./env.nix
  ];

  programs.home-manager.enable = true;
}
