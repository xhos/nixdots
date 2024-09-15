{ inputs, pkgs, lib, config, ... }: {
  nixpkgs.overlays = lib.mkIf config.modules.wezterm.enable [
    inputs.nur.overlay (
      final: prev:
      let
        inherit (final) callPackage runCommand;
      in {
        wezterm = callPackage ../../../derivs/wezterm.nix {
          wezterm-flake = inputs.wezterm;
          naersk = callPackage inputs.naersk { };
        };
      }
    )
  ];
}
