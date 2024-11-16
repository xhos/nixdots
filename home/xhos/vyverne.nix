{pkgs, ...}: {
  # https://tinted-theming.github.io/base16-gallery/
  theme = "tokyo-night-dark";
  wallsDir = "/home/xhos/Pictures/walls";

  imports = [../../modules/home];

  modules = {
    rofi.enable = true;
    spicetify.enable = true;
    firefox.enable = true;
    discord.enable = true;
    nvidia.enable = true;
  };

  default = {
    de = "hyprland";
    bar = "waybar";
    lock = "hyprlock";
    shell = "zsh";
    prompt = "starship";
    terminal = "foot";
    browser = "zen";
  };

  home.packages = with pkgs; [
    sqldeveloper
    jetbrains.datagrip
    (vscode.override {commandLineArgs = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];})
  ];

  programs.waybar.settings.mainBar.output = ["DP-3"];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace special silent] spotify"
      "[workspace special silent] telegram-desktop"
      "[workspace 9 silent] obsidian"
      "[workspace 10 silent] discord"
    ];

    windowrulev2 = [
      "workspace special silent, initialTitle: Spotify Premium"
      "workspace special silent, class:(org.telegram.desktop)"
      "size 600,class:(org.telegram.desktop)"
    ];

    workspace = [
      "1,monitor:DP-3,default:true"
      "2,monitor:HDMI-A-1,default:true"
    ];

    monitor = [
      "DP-3,1920x1080@239.76,1080x450,1"
      "HDMI-A-1,1920x1080@144.0,0x0,1"
      "HDMI-A-1,transform,1"
    ];
  };
}
