# my NixOS config

## main features

- full system theming with stylix
- secret management with sops-nix
- custom driver for my samsung galaxy book 2 pro 360
- touch support with hyprgrass
- OneDrive and ProtonDrive mounted via [rclone](https://rclone.org) as [custom systemd services](modules/nixos/opt/rclone.nix)
- pre configured web apps

## themed apps

> most of theese automaticly follow the stylix set base-16 color scheme

- discord:  [system24](https://github.com/refact0r/system24)
- firefox:  [scifox](https://github.com/scientiac/scifox)
- obsidian: [anuPpuccin](https://github.com/AnubisNekhet/AnuPpuccin)
- spotify:  [text](https://github.com/spicetify/spicetify-themes/tree/master/text)
- and more that I'm forgetting...

## info

app runner:           [rofi](https://github.com/davatorium/rofi)
clipboard manager:    [clipse](https://github.com/savedra1/clipse)
compositor:           [hyprland](https://github.com/hyprwm/Hyprland)
fetch:                [fastfetch](https://github.com/fastfetch-cli/fastfetch)
file manager:         [nautilus](https://gitlab.gnome.org/GNOME/nautilus)
notifications deamon: [mako](https://github.com/emersion/mako)
wallpaper setter:     [swww](https://github.com/LGFae/swww)

### terminals

- wezterm
- **foot**
- kitty
- alacritty

### shells

- nushell
- **fish**
- zsh

### prompts

- **starship**
- oh-my-posh

### bars

- **waybar**

## install
(notes to self, not really instructions)

*must in bash fot commands to work*

```bash
nix-shell -p git home-manager
sudo rm -r /etc/nixos/*
sudo git clone https://github.com/$USER/nixdots /etc/nixos
cd /etc/nixos
sudo nixos-generate-config
rm configuration.nix
sudo mv hardware-configuration.nix hosts/$HOSTNAME/hardware-configuration.nix 
home-manager switch --flake .#$USER@$HOSTNAME --extra-experimental-features "nix-command flakes" -b b
sudo nixos-rebuild switch --flake .#$HOSTNAME
```

</details>

## post install

<details>
  <summary>sops-nix</summary>

get user (dev) key for sops:

```bash
mkdir .config/sops/age
age-keygen -o .config/sops/age/keys.txt
```

get age publick key from the machine ssh key to put into .sops.yaml:

```bash
nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
```

if any erros with keys, or after key change:

```bash
sops updatekeys /etc/nixos/core/secrets/secrets.yaml
```

`note: if no key is able to decrypt this command will fail`

copy ssh key into `/hosts`

```bash
cp /etc/ssh/ssh_host_ed25519_key.pub /etc/nixos/hosts/zireael/zireael.pub
```

put password hash into secrets.yaml, to get hash:

```bash
mkpasswd -s
```
</details>
<details>
  <summary>configuring onedrive with rclone</summary>

```bash
mkdir ~/onedrive
```

```bash
rclone config
```
</details>

### updating

```bash
cd /etc/nixos/ && nix flake update && nh home switch && nh os switch
```

### WSL install

Enable WSL if you haven't done already:

```bash
wsl --install --no-distribution
```

Download nixos-wsl.tar.gz from the [latest release](https://github.com/nix-community/NixOS-WSL/releases/latest).

Import the tarball into WSL:

```bash
    wsl --import NixOS --version 2 $env:USERPROFILE\NixOS\ nixos-wsl.tar.gz
```

You can now run NixOS:

```bash
    wsl -d NixOS
```

For more detailed instructions, [refer to the documentation](https://nix-community.github.io/NixOS-WSL/install.html).

## Credit/Thanks ❤️

- [@joshuagrisham](https://github.com/joshuagrisham) for his magnificent work on [the galaxy book driver](https://github.com/joshuagrisham/samsung-galaxybook-extras)

- [@ItzDerock](https://github.com/ItzDerock) for sharing his [nix derivation](https://github.com/joshuagrisham/samsung-galaxybook-extras/issues/14#issue-2328871732) for that driver

- [@elyth](https://github.com/elythh), my config started as a fork of his [flake](https://github.com/elythh/flake)

- [@MrVivekRajan](https://github.com/MrVivekRajan/) for hyprlock [style](https://github.com/MrVivekRajan/Hyprlock-Styles) inspiration
