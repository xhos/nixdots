{
  programs.plasma.panels = [
    # Application name, Global menu and Song information and playback controls at the top
    {
      location = "top";
      height = 26;
      widgets = [
        {
          applicationTitleBar = {
            behavior = {
              activeTaskSource = "activeTask";
            };
            layout = {
              elements = ["windowTitle"];
              horizontalAlignment = "left";
              showDisabledElements = "deactivated";
              verticalAlignment = "center";
            };
            overrideForMaximized.enable = false;
            titleReplacements = [
              {
                type = "regexp";
                originalTitle = "^Brave Web Browser$";
                newTitle = "Brave";
              }
              {
                type = "regexp";
                originalTitle = ''\\bDolphin\\b'';
                newTitle = "File manager";
              }
            ];
            windowTitle = {
              font = {
                bold = false;
                fit = "fixedSize";
                size = 12;
              };
              hideEmptyTitle = true;
              margins = {
                bottom = 0;
                left = 10;
                right = 5;
                top = 0;
              };
              source = "appName";
            };
          };
        }
        "org.kde.plasma.appmenu"
        "org.kde.plasma.panelspacer"
        {
          plasmusicToolbar = {
            panelIcon = {
              albumCover = {
                useAsIcon = false;
                radius = 8;
              };
              icon = "view-media-track";
            };
            playbackSource = "auto";
            musicControls.showPlaybackControls = true;
            songText = {
              displayInSeparateLines = true;
              maximumWidth = 640;
              scrolling = {
                behavior = "alwaysScroll";
                speed = 3;
              };
            };
          };
        }
      ];
    }
  ];
}
