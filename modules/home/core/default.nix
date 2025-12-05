{
  imports = [
    ./home.nix
    ./nixpkgs.nix
    ./options.nix
    ./ssh.nix
    ./zellij.nix
    ./env.nix
    ./oci.nix
  ];

  programs.home-manager.enable = true;
}
