{inputs, ...}: {
  users.users.xhos = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialPassword = ""; # live-ISO convenience
  };

  # home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {inherit inputs;};

  home-manager.users."xhos" = ./nyx.nix;
}
