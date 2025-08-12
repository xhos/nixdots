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
      # telegram
      ".local/share/materialgram/tdata"
      ".cache/stylix-telegram-theme"

      # zed
      ".local/share/zed"
      ".config/zed"

      # jetbrains
      ".local/share/JetBrains"
      ".config/JetBrains"
      ".cache/JetBrains"
      ".java" # jetbrains for some miraculous reason store auth in ~/.java

      # discord
      ".config/discord"
      ".config/Vencord"

      # claude
      ".claude"
      ".config/Claude/"

      # misc configs
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
      ".config/nvim"

      ".local/share/PrismLauncher"
      ".local/share/direnv"
      ".local/share/zoxide" # zoxide i lv u, plz don't hv amnesia

      ".cache/huggingface" # i like my models not in ram
      ".cache/Proton" # proton stores their login stuff in cache for some reason

      ".zen"
      ".mozilla"
      ".vscode"
      ".ssh"
      "work"
      "Projects"
      "Music"
      "Documents"
      "Downloads"
      "Pictures"
      "Videos"
    ];

    files = [
      ".wakatime.cfg" # micromanage myself
      ".zsh_history" # fight amnesia
      ".config/OpenRGB/config.json" # i lv my lights glowing
      ".claude.json"
    ];

    allowOther = true;
  };

  optPkgs.enable = true;

  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/7p/wallhaven-7pr53v.jpg";
    sha256 = "sha256-S3z3kpv9DGQ3zO/2Ra1zm7+SMvJ+duE0jliJlvwv8FM=";
  };

  services.kdeconnect.enable = true;

  modules = {
    rofi.enable = true;
    spicetify.enable = true;
    firefox.enable = true;
    discord.enable = true;
    secrets.enable = true;
    telegram.enable = true;
    obs.enable = true;
    whisper.enable = true;
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
    # jetbrains.goland
    # jetbrains.datagrip
    firefox
    termius
    lollypop
    inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
    # go
    # wireguard-tools
    # iptables
    (vscode.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    })
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
