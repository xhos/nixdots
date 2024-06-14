{config, ...}:
with config.lib.stylix.colors; {
  home.file.".config/Vencord/themes/chadcat7.css".text = ''
    /**
     * @name Elyth
     * @description A darkened discord theme generated via home manager.
     * @author refact0r
     * @version 1.6.1
     * @source https://github.com/refact0r/midnight-discord
     * @authorId 508863359777505290
    */

    /* IMPORTANT: make sure to enable dark mode in discord settings for the theme to apply properly!! */

    @import url('https://refact0r.github.io/midnight-discord/midnight.css');

    /* change colors and variables here */
    :root {
    	/* amount of spacing and padding */
    	--spacing: 12px;
    	/* radius of round corners */
    	--roundness: 16px;

    	/* font, change to 'gg sans' for default discord font*/
    	--font: 'figtree';

    	/* color of green online dot, change to #23a55a for default green */
    	--online-indicator: var(--accent-2);

    	/* top left icon */
    	--moon-icon: block; /* change to 'none' to hide moon icon */
    	--discord-icon: none; /* change to 'block' to show default discord icon */

    	/* color of links */
    	--accent-1: #${base05};
    	/* color of unread dividers and some indicators */
    	--accent-2: #${base05};
    	/* color of accented buttons */
    	--accent-3: #${base0D};
    	/* color of accented buttons when hovered */
    	--accent-4: #${base0D};
    	/* color of accented buttons when clicked */
    	--accent-5: #${base0D};

    	/* color of mentions and messages that mention you */
    	--mention: hsla(190, 80%, 52%, 0.1);
    	/* color of mentions and messages that mention you when hovered */
    	--mention-hover: hsla(190, 80%, 52%, 0.05);

    	/* color of bright text on colored buttons */
    	--text-1: #${base05};
    	/* color of headings and important text */
    	--text-2: #${base05};
    	/* color of normal text */
    	--text-3: #${base05};
    	/* color of icon buttons and channels */
    	--text-4: #${base05};
    	/* color of muted channels/chats and timestamps */
    	--text-5: #${base05};

    	/* color of dark buttons when clicked */
    	--bg-1: #${base00};
    	/* color of dark buttons */
    	--bg-2: #${base00};
    	/* color of spacing around panels and secondary elements */
    	--bg-3:  #${base00};
    	/* main background color */
    	--bg-4: #${base00};

    	/* color of channels and icon buttons when hovered */
    	--hover: hsla(230, 20%, 40%, 0.1);
    	/* color of channels and icon buttons when clicked or selected */
    	--active: hsla(220, 20%, 40%, 0.2);
    	/* color of messages when hovered */
    	--message-hover: hsla(220, 0%, 0%, 0.1);
    }
  '';
}
