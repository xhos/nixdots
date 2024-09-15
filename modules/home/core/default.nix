{ inputs, config, pkgs, ... }: {

  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
  };

  programs.ssh.addKeysToAgent = "yes";

  imports = [
    ./gtk.nix
    ./nixpkgs.nix
    ./options.nix
    ./programs.nix
    ./home.nix
  ];

  programs.home-manager.enable = true;
}
