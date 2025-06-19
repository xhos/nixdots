{
  programs.zsh.shellAliases = {
    ns = "nix-shell -p";
    ff = "fastfetch";
    gcl = "git clone";
    ga = "git add .";
    gp = "git push";
    gc = "git commit -m";
    lg = "lazygit";
    g = "git";
    s = "nix search nixpkgs";
    nhs = "nh home switch";
    nos = "nh os switch";
    img = "swayimg";
    imp = "sudo fd --one-file-system --base-directory / --type f --hidden --exclude \"{tmp,etc/passwd,home/xhos/.cache}\"";
    go-cp-all = "find cmd/ internal/ -name \"*.go\" -exec sh -c 'echo \"--- {} ---\"; cat \"{}\"' \\; | wl-copy";
    b64 = "openssl rand -base64 64 | tr -d '\n' | tr -- '+/' '-_' | tr -d '\n=' | wl-copy";
  };
}
