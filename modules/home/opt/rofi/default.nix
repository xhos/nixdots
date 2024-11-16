{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./style.nix];

  config = lib.mkIf config.modules.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      # font = "Product Sans 12";
      # extraConfig = {
      #   modi = "drun";
      #   display-drun = "";
      #   show-icons = true;
      #   drun-display-format = "{name}";
      #   sidebar-mode = false;
      # };
    };
  };
}
