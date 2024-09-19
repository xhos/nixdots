{ config, lib, inputs, ... }:
    lib.mkIf (config.default.terminal == "alacritty") {
        home.sessionVariables.TERMINAL = "alacritty";
    }
}
