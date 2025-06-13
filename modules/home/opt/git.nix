{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "xhos";
    userEmail = "60789741+xhos@users.noreply.github.com";
    extraConfig = {
      url = {
        "https://github.com/" = {
          insteadOf = ["gh:"];
        };
        "https://github.com/xhos/" = {
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
