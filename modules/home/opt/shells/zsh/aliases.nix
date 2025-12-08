{
  config,
  lib,
  ...
}: {
  programs.zsh = lib.mkIf (config.shell == "zsh") {
    shellAliases = {
      v = "nvim";
      ze = "zellij";

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
      go-cp-all = "find cmd/ internal/ -name \"*.go\" -exec sh -c 'echo \"--- {} ---\"; cat \"{}\"' \\; | wl-copy";
      b64 = "openssl rand -base64 64 | tr -d '\n' | tr -- '+/' '-_' | tr -d '\n=' | wl-copy";

      # impermanence
      imp = "sudo fd --one-file-system --base-directory / --type f --hidden --exclude \"{tmp,etc/passwd,home/xhos/.cache,home/xhos/.cargo,home/xhos/go,var/lib/systemd/coredump}\"";
      nimp = "sudo ncdu -x /";

      u = "uwsm-app --";
    };
    initExtra = ''
      try() {
        nix run nixpkgs#$1 -- "''${@:2}"
      }
    '';
  };
}
