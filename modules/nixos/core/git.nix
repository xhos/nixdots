{
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "xhos";
        email = "60789741+xhos@users.noreply.github.com";
        signingKey = "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGgRlG4m4RWFLHarzFFG5Q4MRyZK737laibKI42aUNhF";
      };
      gpg.format = "ssh";
      commit.gpgsign = true;
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
    };
  };

  programs.lazygit.enable = true;
}
