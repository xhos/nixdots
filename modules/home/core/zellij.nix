{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "tokyo-night-dark";
      pane_frames = false;
      ui = {
        pane_frames = {
          hide_session_name = true;
        };
      };
      show_release_notes = false;
      show_startup_tips = false;
    };
  };
}
