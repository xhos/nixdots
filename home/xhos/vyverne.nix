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
      ".config/nvim"

      ".config/discord"
      ".config/Vencord"

      ".local/share/zoxide"

      ".cache/huggingface" # i like my models not in ram

      "Projects"
      "Documents"
      "Downloads"
      "Pictures"
      "Videos"
    ];

    files = [
      ".wakatime.cfg" # micromanage myself
      ".zsh_history" # fight amnesia
      ".config/OpenRGB/config.json" # i love my lights glowing
    ];

    allowOther = true;
  };

  optPkgs.enable = true;

  stylix.image =
    pkgs.fetchurl
    {
      url = "https://w.wallhaven.cc/full/z8/wallhaven-z8lgwg.jpg";
      sha256 = "sha256-r3f1Wd7SYyJnB55Wp+XD+/YOK4XQCzFDYf9YoPx1Bas=";
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
    termius
    go
    wireguard-tools
    iptables
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
      "desc:Samsung Electric Company LS27AG30x H4PW500403,1920x1080@144.0,2560x0,0.75"
      "desc:Samsung Electric Company LS27AG30x H4PW500403,transform,3"
      "desc:Microstep MAG 274UPF E2 0x00000001,3840x2160@160.0,0x605,1.5"
    ];
  };

  mainMonitor = "Microstep MAG 274UPF E2 0x00000001";
}
