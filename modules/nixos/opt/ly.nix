{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.greeter == "ly") {
    services.displayManager.ly = {
      enable = true;
      settings = {
        # none     -> Nothing
        # doom     -> PSX DOOM fire
        # matrix   -> CMatrix
        # colormix -> Color mixing shader
        # gameoflife -> John Conway's Game of Life
        animation = "colormix";

        bigclock = "en";
        asterisk = "·";
        blankbox = "false";
        clock = "null";
      };
    };
  };
}
