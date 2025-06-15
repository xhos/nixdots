{
  inputs,
  pkgs,
  ...
}: {
  # https://tinted-theming.github.io/base16-gallery/
  theme = "tokyo-night-dark";

  imports = [
    ../../modules/home
    inputs.impermanence.homeManagerModules.impermanence
  ];
  home.persistence."/persist/home/xhos" = {
    directories = [
      ".zen"
      ".mozilla"
      ".vscode"
      ".ssh"

      {
        directory = ".steam";
        method = "symlink";
      }
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }

      ".local/share/materialgram/tdata"
      ".local/share/direnv"
      ".local/share/PrismLauncher"

      ".local/share/zed"
      ".config/zed"

      ".config/pulse"
      ".config/hypr"
      ".config/libreoffice"
      ".config/spotify"
      ".config/vesktop"
      ".config/clipse"
      ".config/Code"

      "Projects"
      "Documents"
      "Downloads"
      "Pictures"
      "Videos"
    ];
    files = [".wakatime.cfg"];
    allowOther = true;
  };

  optPkgs.enable = true;
  wallpaper =
    pkgs.fetchurl
    {
      url = "https://w.wallhaven.cc/full/l8/wallhaven-l86p22.jpg";
      sha256 = "sha256-weEc237eZ8TK8DMNzBDZdPkjS5WMseJ6H4TiJcLC2C4=";
    };
  modules = {
    rofi.enable = true;
    spicetify.enable = true;
    firefox.enable = true;
    discord.enable = true;
  };

  default = {
    de = "hyprland";
    bar = "quickshell";
    lock = "hyprlock";
    shell = "zsh";
    prompt = "starship";
    browser = "zen";
    terminal = "foot";
  };

  home.packages = with pkgs; [
    # davinci-resolve
    jetbrains.goland
    jetbrains.datagrip
    firefox
    go
    (vscode.override {commandLineArgs = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];})
  ];

  hyprland.hyprspace.enable = true;

  wayland.windowManager.hyprland.settings = {
    debug.damage_tracking = 0;

    exec-once = [
      "[workspace special silent] spotify"
    ];

    windowrulev2 = [
      "workspace special silent, initialClass: spotify"
    ];

    monitor = [
      "HDMI-A-1,1920x1080@144.0,2560x0,0.75"
      "HDMI-A-1,transform,3"
      "HDMI-A-2,3840x2160@160.0,0x605,1.5"
    ];
  };
}
