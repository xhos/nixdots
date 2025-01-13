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

get age public key from the machine ssh key to put into .sops.yaml:

```bash
nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
```

if there are any erros with the keys, or after the keys were changed:

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
