{
  inputs,
  pkgs,
  ...
}: {
  imports = [../../modules/home];

  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/ex/wallhaven-exkqk8.jpg";
    sha256 = "sha256-HATmU/6OrfgeoPIeUca/QFk3lzKD9NcpJenXQjMgMlU=";
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

  default = {
    de = "hyprland";
    bar = "waybar";
    shell = "zsh";
    prompt = "starship";
    browser = "zen";
    terminal = "foot";
  };

  home.packages = with pkgs; [
    (python3Packages.buildPythonApplication {
      pname = "img2art";
      version = "0.1.0";

      src = fetchFromGitHub {
        owner = "Asthestarsfalll";
        repo = "img2art";
        rev = "a841044ccbd89b57553186a11d8de35371089142";
        sha256 = "sha256-HUGEurYwkJgcJ2r2ty8sWjK1oKpXAcSO2AtfLfd6LR4=";
      };

      format = "pyproject";

      nativeBuildInputs = with python3Packages; [
        poetry-core
      ];

      propagatedBuildInputs = with python3Packages; [
        typer
        opencv-python
        numpy
      ];

      meta = with lib; {
        description = "Convert images, GIFs, and videos to ASCII art";
        homepage = "https://github.com/Asthestarsfalll/img2art";
        license = licenses.mit;
        maintainers = [];
      };
    })
    # davinci-resolve
    # jetbrains.goland
    # jetbrains.datagrip
    oci-cli
    firefox
    termius
    lollypop
    inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
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
