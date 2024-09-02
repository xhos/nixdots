{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "xhos";
    userEmail = "60789741+xhos@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
      credential.helper = "${
        pkgs.git.override { withLibsecret = true; }
      }/bin/git-credential-libsecret";
    };
  };
}
