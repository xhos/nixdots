{ inputs }:
final: prev:
let
  inherit (final)
    callPackage
    runCommand
    ;
in
{
  wezterm = callPackage ./drvs/wezterm {
    wezterm-flake = inputs.wezterm;
    naersk = callPackage inputs.naersk { };
  };
}
