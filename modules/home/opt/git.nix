{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "xhos";
    userEmail = "60789741+xhos@users.noreply.github.com";

    signing = {
      format = "ssh";
      key = "~/.ssh/github-auth-key.pub";
      signByDefault = true;
    };

    extraConfig = {
      url = {
        "https://github.com/" = {
          insteadOf = ["gh:"];
        };
        "git@github.com:xhos/" = {
          insteadOf = ["x:"];
        };
      };
      status = {
        branch = true;
        showStash = true;
        showUntrackedFiles = "all";
      };
      core.fileMode = false;
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };
  };
}
