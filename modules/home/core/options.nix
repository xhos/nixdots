{lib, ...}:
with lib; {
  options.wallpaper = mkOption {
    type = types.path;
    default = "";
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
}
