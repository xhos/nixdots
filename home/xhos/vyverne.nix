{pkgs, ...}: {
  # https://tinted-theming.github.io/base16-gallery/
  theme = "tokyo-night-dark";
  wallsDir = "/home/xhos/Pictures/walls";

  imports = [../../modules/home];

  modules = {
    rofi.enable = true;
    spicetify.enable = true;
    firefox.enable = true;
    discord.enable = false;
  };

  default = {
    de = "none";
    bar = "none";
    lock = "none";
    shell = "zsh";
    prompt = "starship";
    browser = "zen";
    terminal = "foot";
  };

  home.packages = with pkgs; [
    # vesktop
    (vscode.override {commandLineArgs = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];})
  ];

  programs.waybar.settings.mainBar.output = ["DP-3"];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace special silent] spotify"
      "[workspace special silent] materialgram"
      "[workspace 1 silent] zen"
      "[workspace 9 silent] obsidian"
      "[workspace 10 silent] vesktop"
    ];

    windowrulev2 = [
      "workspace special silent, initialTitle: Spotify Premium"
      "workspace special silent, class:(materialgram)"
    ];

    workspace = [
      "1,monitor:DP-3,default:true"
      "2,monitor:HDMI-A-1,default:true"
      "9,monitor:DP-3"
      "10,monitor:DP-3"
    ];

    monitor = [
      "HDMI-A-1,1920x1080@144.0,1920x0,1.0"
      "HDMI-A-1,transform,3"
      # "HDMI-A-1,1920x1080@144.0,1920x0,1.0,mirror,DP-3"
      "DP-3,1920x1080@239.76,0x444,1.0"
    ];
  };
}
