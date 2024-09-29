{ inputs, config, pkgs, ... }: {

  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
  };

  programs.ssh.addKeysToAgent = "yes";

  imports = [
    ./fonts
    ./nixpkgs.nix
    ./options.nix
    ./programs.nix
    ./home.nix
  ];

  gtk = {
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {color = "nordic";};
    };
  };
  
  programs.home-manager.enable = true;
}
