{
  programs.nixcord = {
    enable = true;  # enable Nixcord. Also installs discord package
    quickCss = ''
    /* Sidebar */
    .sidebar_a4d4d9 {
      background: #000000 !important; /* Set background to black */
    }

    /* Server List */
    .folder_bc7085,
    .expandedFolderBackground_bc7085 {
      background-color: #111111 !important; /* Darken folder color */
    }
    .folder_bc7085:hover {
      background-color: #222222 !important; /* Darken hover color */
    }
    '';  # quickCSS file
    config = {
      useQuickCss = true;   # use out quickCSS
      # themeLinks = [
        # "https://raw.githubusercontent.com/TheCommieAxolotl/BetterDiscord-Stuff/main/Ultra/Ultra.css"
      # ];
      frameless = true; # set some Vencord options
      plugins = {
        reverseImageSearch.enable = true;
        petpet.enable = true;
        noScreensharePreview.enable = true;
        messageLogger.enable = true;
        loadingQuotes = {
          enable = true;
          enablePluginPresetQuotes = false;
          # Titanfall 2 pilot ejection quotes
          additionalQuotes = "It was fun.|Ain't over till it's over.|Until next time, then.|Second star to the right.|Go get 'em, tiger.|Make it so.|See you on the other side.|Wait for the wheel.|Do not throw your shot.|Drop and burn 'em up.|Exhibit no restraint.|Rip and saw.|Code zero zero zero. Destruct. Zero.|Authorization Alpha-Alpha 3-0-5.|Have just the greatest day.|Avenge me.|Stay safe.|Situation normal.|PROTOCOL <3|Fly, you fool.|Never give up. Never surrender.|In case of doubt, attack.|You’re never beaten until you admit it.|Wrong us, shall we not revenge?|Till all are one.|Nothing but the rain.|Sometimes, you have to roll a hard six.|And sometimes, when you fall, you fly.|See you space cowboy...|Just another day at the office.|End of line.|Fortune favors the bold.|A leaf on the wind.|You are who you choose to be.|Always.|Finish the fight.";
        };
        gameActivityToggle.enable = true;
        friendsSince.enable = true;
        fixSpotifyEmbeds.enable = true;
        decor.enable = true;
        callTimer.enable = true;
        biggerStreamPreview.enable = true;
      };
    };
    extraConfig = {
      # Some extra JSON config here
      # ...
    };
  };
}
