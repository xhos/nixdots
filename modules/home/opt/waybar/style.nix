{ config, ... }: { programs.waybar.style = ''

* {
    border: none;
    border-radius: 0px;
    font-family: Iosevka, FontAwesome, Noto Sans CJK;
    font-size: 14px;
    min-height: 0;
}

window#waybar {
    background: rgba(30, 30, 46, 0.5);
    color: #${config.accent}
}

#workspaces {
    background: #${config.background};
    margin: 5px 5px;
    padding: 8px 5px;
    border-radius: 16px;
    color: #${config.accent};
}

#workspaces button {
    padding: 0px 5px;
    margin: 0px 3px;
    border-radius: 16px;
    color: transparent;
    background: #${config.lib.stylix.colors.base01};
    transition: all 0.3s ease-in-out;
}

#workspaces button.active {
    background-color: #${config.accent};
    color: #${config.background};
    border-radius: 16px;
    min-width: 50px;
    background-size: 400% 400%;
    transition: all 0.3s ease-in-out;
}

#workspaces button:hover {
    background-color: #${config.text};
    color: #${config.background};
    border-radius: 16px;
    min-width: 50px;
    background-size: 400% 400%;
}

#tray, #pulseaudio, #battery,
#custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.foward{
    background: #${config.background};
    font-weight: bold;
}

#tray, #pulseaudio, #battery{
    color: #${config.text};
    border-radius: 20px;
    padding: 0 20px;
    margin-left: 7px;
}

#clock {
    color: #${config.text};
    font-weight: bold;
    font-size: 18px;
    margin-left: 2px;
}

#custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.foward {
    background: #${config.background};
    font-size: 22px;
}

#custom-playerctl.backward:hover, #custom-playerctl.play:hover, #custom-playerctl.foward:hover{
    color: #${config.text};
}

#custom-playerctl.backward {
    color: #${config.accent};
    border-radius: 20px 0px 0px 20px;
    padding-left: 16px;
    margin-left: 7px;
}

#custom-playerctl.play {
    color: #${config.accent};
    padding: 0 5px;
}

#custom-playerctl.foward {
    color: #${config.accent};
    border-radius: 0px 20px 20px 0px;
    padding-right: 12px;
    margin-right: 7px
}

#custom-playerlabel {
    background: transparent;
    color: #${config.text};
    margin: 5px 0;
    font-weight: bold;
}

#window{
    background: #${config.background};
    padding-left: 15px;
    padding-right: 15px;
    border-radius: 16px;
    margin-top: 5px;
    margin-bottom: 5px;
    font-weight: normal;
    font-style: normal;
}        

'';}
