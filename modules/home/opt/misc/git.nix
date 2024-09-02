{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "xhos";
    userEmail = "xxhos@pm.me";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
      credential.helper = "${
        pkgs.git.override { withLibsecret = true; }
      }/bin/git-credential-libsecret";
    };
  };
}
