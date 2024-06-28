{ pkgs, ... }:
modeSwithcer = pkgs.writeShellApplication {
  name = "modeSwitcher";

  text = ''
    ls -l
  '';
}