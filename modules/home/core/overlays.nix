{inputs, pkgs, lib, ...}:

{
  nixpkgs.overlays = [
    inputs.nur.overlay (final: prev:
    
let
  inherit (final)
    callPackage
    runCommand
    ;
in  {

  wezterm = callPackage ../../../derivs/wezterm.nix {
    wezterm-flake = inputs.wezterm;
    naersk = callPackage inputs.naersk { };
  };
      # wezterm = prev.wezterm.overrideAttrs (old: {
      #   src = prev.fetchFromGitHub {
      #     owner = "wez";
      #     repo = "wezterm";
      #     rev = "404c1937ef1194a528d57f8096d7215a8faabc5e";
      #     fetchSubmodules = true;
      #     hash = "sha256-TLMt5dNCuTNszz40iwQgQPdEnOm/XldMbZ1tcp88VdQ=";
      #   };
      #   cargoDeps = old.cargoDeps.overrideAttrs (prev.lib.const {
      #     name = "wezterm-vendor.tar.gz";
      #     inherit src;
      #     outputHash = "sha256-QCEyl5FZqECYYb5eRm8mn+R6owt+CLQwCq/AMMPygE0=";
      #   });
      # });

    })
  ];
  # home.packages = [ pkgs.wezterm ];
}
