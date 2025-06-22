{
  inputs,
  pkgs,
  ...
}: {
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

      ".local/share/materialgram/tdata"
      ".local/share/direnv"
      ".local/share/PrismLauncher"

      ".local/share/zed"
      ".config/zed"

      ".local/share/JetBrains"
      ".config/JetBrains"

      ".config/pulse"
      ".config/hypr"
      ".config/libreoffice"
      ".config/spotify"
      ".config/vesktop"
      ".config/clipse"
      ".config/Code"
      ".config/obsidian"
      ".config/chromium"
      ".config/sops"
      ".config/waybar"

      ".local/share/caelestia"
      ".local/state/caelestia"
      ".config/caelestia"

      "Projects"
      "Documents"
      "Downloads"
      "Pictures"
      "Videos"
    ];

    files = [
      ".wakatime.cfg"
      ".zsh_history"
      ".config/OpenRGB/config.json"
    ];

    allowOther = true;
  };

  optPkgs.enable = true;

  stylix.image =
    pkgs.fetchurl
    {
      url = "https://w.wallhaven.cc/full/o3/wallhaven-o3km89.png";
      sha256 = "sha256-11Dk/EDBQPH9V/+RnMAkMBsW7wLhFiv8qU4ve72jT8A=";
    };

  modules = {
    rofi.enable = true;
    spicetify.enable = true;
    firefox.enable = true;
    discord.enable = true;
    secrets.enable = true;
  };

  default = {
    de = "hyprland";
    bar = "waybar";
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
      "HDMI-A-2,1920x1080@144.0,2560x0,0.75"
      "HDMI-A-2,transform,3"
      "HDMI-A-1,3840x2160@160.0,0x605,1.5"
    ];
  };
}
