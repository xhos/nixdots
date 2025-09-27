{
  imports = [
    ./home.nix
    ./nixpkgs.nix
    ./options.nix
    ./programs.nix
    ./ssh.nix
    ./zellij.nix
    ./env.nix
  ];

  programs.home-manager.enable = true;
}
