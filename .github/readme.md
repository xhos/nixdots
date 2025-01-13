# nixdots

## main features

- full system theming with stylix
- secret management with sops-nix
- custom driver for my samsung galaxy book 2 pro 360
- touch support with hyprgrass
- OneDrive and ProtonDrive mounted via [rclone](https://rclone.org) as [custom systemd services](modules/nixos/opt/rclone.nix)
- pre configured web apps

## :package: repo contents

- **[derivs](../derivs):** nixpkgs overlays/derivations
- **[home](../home):** [home-manager](https://github.com/nix-community/home-manager) configurations
- **[hosts](../hosts):** host-specific configurations
- **[modules](../modules):**
  - **[home](../modules/home):** home-manager related modules
    - **[core](../modules/home/core):** core modules
    - **[opt](../modules/home/opt):** optional and togglable modules
  - **[nixos](../modules/nixos):** NixOS related modules
    - **[core](../modules/nixos/core):** core modules
    - **[opt](../modules/nixos/opt):** optional and togglable modules

## :paintbrush: themed apps

> [!NOTE]
> most of these automaticly follow the stylix color scheme

- discord:  [system24](https://github.com/refact0r/system24)
- firefox:  [scifox](https://github.com/scientiac/scifox)
- obsidian: [anuPpuccin](https://github.com/AnubisNekhet/AnuPpuccin)
- spotify:  [text](https://github.com/spicetify/spicetify-themes/tree/master/text)
- and more that I'm forgetting...

## derivations

- [Galaxy Book Extras](../derivs/samsung-galaxybook-extras.nix) - driver for my laptop
- [SDDM Astronaut Theme](../derivs/sddm-astronaut-theme.nix) - colletion of themes for SDDM
- [Yorha Grub Theme](../derivs/yorha-grub-theme.nix) - Nier themed grub screen

## info

| Component         | Details                                                 |
| ----------------- | ------------------------------------------------------- |
| app runner        | [rofi](https://github.com/davatorium/rofi)              |
| clipboard manager | [clipse](https://github.com/savedra1/clipse)            |
| fetch             | [fastfetch](https://github.com/fastfetch-cli/fastfetch) |
| Editor            | [Custom Nixvim flake](https://github.com/elythh/nixvim) |
| Bar               | [waybar](https://github.com/Alexays/Waybar)             |
| Notification      | [mako](https://github.com/emersion/mako)                |

Nix allows for easy switching of components in the setup, so here are the ones I have defined (bold text being my main pick):

### desktop enviroments

- **hyprland**
- plasma
- xfce

### terminals

- alacritty
- **foot**
- ghostty
- kitty
- wezterm

### shells

- nushell
- fish
- **zsh**

### prompts

- **starship**
- oh-my-posh

### flie managers

- **nautils**
- dolphin
- yazi

## :bulb: Acknowledgments

- [@joshuagrisham](https://github.com/joshuagrisham) for his magnificent work on [the galaxy book driver](https://github.com/joshuagrisham/samsung-galaxybook-extras)

- [@ItzDerock](https://github.com/ItzDerock) for sharing his [nix derivation](https://github.com/joshuagrisham/samsung-galaxybook-extras/issues/14#issue-2328871732) for that driver

- [@elyth](https://github.com/elythh), my config started as a fork of his [flake](https://github.com/elythh/flake)

- [@MrVivekRajan](https://github.com/MrVivekRajan/) for hyprlock [style](https://github.com/MrVivekRajan/Hyprlock-Styles) inspiration
