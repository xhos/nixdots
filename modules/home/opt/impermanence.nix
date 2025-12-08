{
  inputs,
  lib,
  config,
  ...
}: let
  persistIf = condition: persistConfig: lib.mkIf condition persistConfig;
  moduleEnabled = module: config.modules.${module}.enable or false;
in {
  imports = [inputs.impermanence.homeManagerModules.impermanence];

  home.persistence."/persist/home/xhos" = lib.mkIf config.impermanence.enable (lib.mkMerge [
    {
      directories = [
        ".local/share/nautilus" # nautilus bookmarks

        ".config/claude"
        ".local/state/wireplumber"

        # jetbrains
        ".local/share/JetBrains"
        ".config/JetBrains"
        ".cache/JetBrains"
        ".java" # jetbrains for some miraculous reason stores auth here

        # claude
        ".claude"
        ".config/Claude/"

        # misc configs
        ".config/pulse"
        ".config/libreoffice"
        ".config/spotify"
        ".config/calibre"
        ".config/clipse"
        ".config/Code"
        ".config/obsidian"
        ".config/chromium"
        ".config/github-copilot" # zed stores its copilot auth here
        ".config/sops"
        ".config/nvim"
        ".config/obs-studio"

        ".local/share/PrismLauncher"
        ".local/share/direnv"
        ".local/share/zoxide" # zoxide i lv u, plz don't hv amnesia

        ".cache/huggingface" # i like my models not in ram
        ".cache/Proton" # proton stores their login stuff in cache for some reason

        # should techically be only enabled when steam is but oh well
        ".config/r2modmanPlus-local"
        ".config/r2modman"

        ".config/rclone" # rclone configs
        ".local/share/nvim"
        ".local/state/nvf/"
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

        # big dev caches
        ".cache/go-build"
        ".cache/.bun"

        ".config/zsh"
        ".local/share/zsh"
        ".config/OpenRGB"
      ];

      allowOther = true;
    }

    (persistIf (moduleEnabled "telegram") {
      directories = [
        ".local/share/materialgram/tdata"
        ".cache/stylix-telegram-theme"
      ];
    })

    (persistIf (moduleEnabled "discord") {
      directories = [
        ".config/discord"
      ];
    })

    (lib.mkIf (config.de == "hyprland") {
      files = [
        ".config/hypr/monitors.conf"
      ];
    })

    (persistIf config.headless {
      directories = [
        ".cloudflared"
        ".vscode-server"
        ".zed_server"
      ];
    })
  ]);
}
