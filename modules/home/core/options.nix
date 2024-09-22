{lib, ...}:
with lib; {
  options.wallpaper = mkOption {
    type = types.path; # TODO: Fix this
    default = /etc/nixos/home/shared/walls/apathy.jpg;
  };
  options.theme = mkOption {
    type = types.str;
    default = "";
  };
  options.accent = mkOption {
    type = types.str;
    default = "";
  };
  options.text = mkOption {
    type = types.str;
    default = "";
  };
  options.background = mkOption {
    type = types.str;
    default = "";
  };
  options.mantle = mkOption {
    type = types.str;
    default = "";
  };
  options.surface0 = mkOption {
    type = types.str;
    default = "";
  };
  options.surface1 = mkOption {
    type = types.str;
    default = "";
  };
  options.surface2 = mkOption {
    type = types.str;
    default = "";
  };
  options.rosewater = mkOption {
    type = types.str;
    default = "";
  };
  options.lavender = mkOption {
    type = types.str;
    default = "";
  };
  options.red = mkOption {
    type = types.str;
    default = "";
  };
  options.peach = mkOption {
    type = types.str;
    default = "";
  };
  options.yellow = mkOption {
    type = types.str;
    default = "";
  };
  options.green = mkOption {
    type = types.str;
    default = "";
  };
  options.teal = mkOption {
    type = types.str;
    default = "";
  };
  options.blue = mkOption {
    type = types.str;
    default = "";
  };
  options.mauve = mkOption {
    type = types.str;
    default = "";
  };
  options.flamingo = mkOption {
    type = types.str;
    default = "";
  };
}
