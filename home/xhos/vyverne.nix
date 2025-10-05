{
  inputs,
  pkgs,
  ...
}: {
  imports = [../../modules/home];

  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/z8/wallhaven-z8lgwg.jpg";
    sha256 = "sha256-r3f1Wd7SYyJnB55Wp+XD+/YOK4XQCzFDYf9YoPx1Bas=";
  };

  services.kdeconnect.enable = true;

  impermanence.enable = true;

  modules = {
    rofi.enable = true;
    spicetify.enable = true;
    firefox.enable = true;
    discord.enable = true;
    secrets.enable = true;
    telegram.enable = true;
    obs.enable = true;
    whisper.enable = true;
    fonts.enable = true;
  };

  de = "hyprland";
  bar = "waybar";
  shell = "zsh";
  prompt = "starship";
  browser = "zen";
  terminal = "foot";

  home.packages = with pkgs; [
    # davinci-resolve
    # jetbrains.goland
    # jetbrains.datagrip
    # oci-cli
    firefox
    # termius
    lollypop
    inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
    (vscode.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    })
  ];

  # hyprland.hyprspace.enable = true; # FIXME currently broken https://github.com/nixos/nixpkgs/issues/443989

  mainMonitor = "Microstep MAG 274UPF E2 0x00000001";

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace special silent] spotify"
      "[workspace 10 silent] materialgram"
      "[workspace 10 silent] equibop"
    ];

    windowrulev2 = [
      "workspace special silent, initialClass: spotify"
      "workspace 10 silent, initialClass: equibop"
      "workspace 10 silent, initialTitle: materialgram"
    ];

    monitor = [
      "desc:Samsung Electric Company LS27AG30x H4PW500403,1920x1080@144.0,2560x0,0.75"
      "desc:Samsung Electric Company LS27AG30x H4PW500403,transform,3"
      "desc:Microstep MAG 274UPF E2 0x00000001,3840x2160@160.0,0x605,1.5"
    ];
  };
}
