# ❄️ nixdots

<p float="left">
  <img src="./ss1.png" width="400" />
  <img src="./ss2.png" width="400" /> 
  <img src="./ss3.png" width="400" />
  <img src="./ss4.png" width="400" />
</p>

## 🌌 main features

- modular setup, everything is toggleable and switchable
- easy full system theming with stylix, based on the wallpaper or a base16 scheme
- secret management with sops-nix
- touch support with hyprgrass
- integrated onedrive & protondrive mounts 
- preconfigured web apps
- fully-themed login screens with sddm and grub

## 📦 repo structure

- **[derivs](../derivs):** nixpkgs overlays/derivations
- **[home](../home):** home-manager configurations
- **[hosts](../hosts):** host-specific configurations
- **[modules](../modules):**
  - **[home](../modules/home):** home-manager related modules
    - **[core](../modules/home/core):** core modules
    - **[opt](../modules/home/opt):** optional and toggleable modules
  - **[nixos](../modules/nixos):** nixos related modules
    - **[core](../modules/nixos/core):** core modules
    - **[opt](../modules/nixos/opt):** optional and toggleable modules

## ℹ️ info

> [!note]
> nix allows for easy switching of components in the setup, so here are the ones i have defined (bold text being my main pick):
> 
> | component            | details                                                 |
> | -------------------- | ------------------------------------------------------- |
> | app runner           | [rofi](https://github.com/davatorium/rofi)              |
> | clipboard manager    | [clipse](https://github.com/savedra1/clipse)            |
> | fetch                | [fastfetch](https://github.com/fastfetch-cli/fastfetch) |
> | bar                  | [aard](https://github.com/xhos/aard)                    |
> | notification         | [mako](https://github.com/emersion/mako)                |
> | desktop environments | **hyprland**, plasma, xfce                              |
> | terminals            | alacritty, **foot**, ghostty, kitty, wezterm            |
> | shells               | nushell, fish, **zsh**                                  |
> | prompts              | **starship**, oh-my-posh                                |
> | file managers        | **nautilus**, dolphin, yazi                             |

## 🔒️ hyprlock

| name | preview | sources |
| :--- | :--- | :--- |
| **Main (Animated)** | <img src="./hyprlock.gif" alt="main Hyprlock Style" width="400" /> | [config](https://github.com/xhos/nixdots/tree/9692b91df9fa7896a59af807010780d1c9bffad7/modules/home/opt/hypr/hyprlock/hyprlock.conf) <br> [assets](https://github.com/xhos/nixdots/tree/9692b91df9fa7896a59af807010780d1c9bffad7/modules/home/opt/hypr/hyprlock/assets/) <br> [scripts](https://github.com/xhos/nixdots/tree/9692b91df9fa7896a59af807010780d1c9bffad7/modules/home/opt/hypr/hyprlock/scripts/) <br> [fonts](../modules/home/core/fonts/font-files/) |
| **Alternative (Static)** | <img src="./hyprlock-alt.png" alt="alternative Hyprlock Style" width="400" /> | [config](https://github.com/xhos/nixdots/tree/9692b91df9fa7896a59af807010780d1c9bffad7/modules/home/opt/hypr/hyprlock/hyprlock-alt.conf) <br> [assets](https://github.com/xhos/nixdots/tree/9692b91df9fa7896a59af807010780d1c9bffad7/modules/home/opt/hypr/hyprlock/assets/) <br> [scripts](https://github.com/xhos/nixdots/tree/9692b91df9fa7896a59af807010780d1c9bffad7/modules/home/opt/hypr/hyprlock/scripts/) <br> [fonts](../modules/home/core/fonts/font-files/) |

fonts used are:
- Maratype (credit to @notevencontestplayer on discord)
- KH Interference
- Synchro
- Nimbus Sans L Thin
- Nimbus Sans Black

## 🖌️ themed apps

> [!note]
> most of these automatically follow the stylix color scheme

- discord:  [system24](https://github.com/refact0r/system24)
- firefox:  [scifox](https://github.com/scientiac/scifox)
- obsidian: [anuppuccin](https://github.com/AnubisNekhet/AnuPpuccin)
- spotify:  [text](https://github.com/spicetify/spicetify-themes/tree/master/text)
- and more that i'm forgetting...

## 📜 derivations 

- [galaxy book extras](../derivs/samsung-galaxybook-extras.nix) - driver for my laptop
- [sddm astronaut theme](../derivs/sddm-astronaut-theme.nix) - collection of themes for sddm
- [yorha grub theme](../derivs/yorha-grub-theme.nix) - nier-themed grub screen

## 💡 acknowledgments

- [@joshuagrisham](https://github.com/joshuagrisham) for his magnificent work on [the galaxy book driver](https://github.com/joshuagrisham/samsung-galaxybook-extras)
- [@itzderock](https://github.com/ItzDerock) for sharing his [nix derivation](https://github.com/joshuagrisham/samsung-galaxybook-extras/issues/14#issue-2328871732) for that driver
- [@elyth](https://github.com/elythh), my config started as a fork of his [flake](https://github.com/elythh/flake)
