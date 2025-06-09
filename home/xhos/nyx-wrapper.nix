{inputs, ...}: {
  users.users.xhos = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialPassword = ""; # live-ISO convenience
  };

  home-manager.extraSpecialArgs = {inherit inputs;};

  home-manager.users."xhos" = ./nyx.nix;
}
