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
