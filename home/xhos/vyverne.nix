{
  inputs,
  pkgs,
  ...
}: {
  imports = [../../modules/home];

  stylix.image = pkgs.fetchurl {
    url = "https://pics.xhos.dev/u/S2DtJS.png";
    sha256 = "sha256-0F8L5DMPLnc4sqwOZ8wqgUipM4rHVK2NxdXJzvVwloM=";
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
    firefox
    xorg.xrandr
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
  };
}
