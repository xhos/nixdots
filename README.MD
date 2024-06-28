# my NixOS config

### main features:

- spicetify with spicetify-nix
- secret management with sops-nix
- cool firefox theme (minfox)

### info:

WM: Hyprland
Runner: rofi

#### terminals:

- **wezterm**
- foot
- kitty

#### shells:

- **nushell**
- fish
- zsh

#### prompts:

- **starship**
- oh-my-posh

#### bars:

- **ags**
- waybar

## post install

get user (dev) key for sops:

```bash
mkdir .config/sops/age
age-keygen -o .config/sops/age/keys.txt
```

get age publick key from the machine ssh key to put into .sops.yaml:

```bash
nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
```

sops updatekeys /etc/nixos/core/secrets/secrets.yaml

❯ mkpasswd -s to get password hash

❯ cp /etc/ssh/ssh_host_ed25519_key.pub /etc/nixos/hosts/zireael/zireael.pub

# Credit/Thanks ❤️

- [@joshuagrisham](https://github.com/joshuagrisham) for his magnificent work on [the galaxy book driver](https://github.com/joshuagrisham/samsung-galaxybook-extras)

- [@ItzDerock](https://github.com/ItzDerock) for sharing his [nix derivation](https://github.com/joshuagrisham/samsung-galaxybook-extras/issues/14#issue-2328871732) for that driver

- [@Aylur](https://github.com/Aylur) for his [beautiful ags setup](https://github.com/Aylur/dotfiles)

- [@elyth](https://github.com/elythh), my config started as a fork of his [flake](https://github.com/elythh/flake)
