{ config, ... }: { programs.waybar.style = ''

* {
    border: none;
    border-radius: 0px;
    font-family: NotoSans Nerd Font Mono;
    font-size:  13px;
    min-height: 0;
}

window#waybar {
    background-color: rgba(0, 0, 0, 1);
    /* border-bottom: 3px solid rgba(100, 114, 125, 0.5); */
    color: #ffffff;
    /* transition-property: background-color; */
    /* transition-duration: .5s; */
    /* border-radius: 0; */
}

#custom-spotify {
    margin:     0px 6px 0px 10px;
    min-width:  10px;
}

#workspaces button {
    /* padding: 0 0.4em; */
    /* background-color: transparent; */
    color: #ffffff;
    /* Use box-shadow instead of border so the text isn't offset */
    box-shadow: inset 0 -3px transparent;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
#workspaces button:hover {
    background: rgba(0, 0, 0, 0.9);
    box-shadow: inset 0 -3px #ffffff;
}

#workspaces button.focused {
    background-color: #64727D;
    /* box-shadow: inset 0 -3px #ffffff; */
}

#workspaces button.urgent {
    background-color: #eb4d4b;
}

#submap {
    background-color: #64727D;
    /* border-bottom: 3px solid #ffffff; */
}

#clock,
#battery,
#cpu,
#memory,
#temperature,
#backlight,
#network,
#pulseaudio,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#mpd {
    padding: 0 10px;
    margin: 6px 3px;
    color: #000000;
}

#window,
#workspaces {
    margin: 0 4px;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#clock {
    background-color: #000000;
    color: white;
}

#battery {
    background-color: #000000;
    color: white;
}

#battery.charging {
    color: #ffffff;
    background-color: #000000;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #000000;
    }
}

#battery.critical:not(.charging) {
    background-color: #f53c3c;
    color: #ffffff;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

label:focus {
    background-color: #000000;
}

#cpu {
    background-color: #000000;
    color: #ffffff;
}

#memory {
    background-color: #000000;
    color: white;
}

#backlight {
    background-color: #000000;
    color:white;
}

#network {
    background-color: #000000;
    color:white;

}

#network.disconnected {
    background-color: #f53c3c;
}

#pulseaudio {
    background-color: #000000;
    color: #ffffff;
}

#pulseaudio.muted {
    background-color: #000000;
    color: #ffffff;
}

#temperature {
    background-color: #f0932b;
}

#temperature.critical {
    background-color: #eb4d4b;
}

#tray {
    background-color: #000;
}

#idle_inhibitor {
    background-color: #2d3436;
}

#idle_inhibitor.activated {
    background-color: #ecf0f1;
    color: #2d3436;
}

#mpd {
    background-color: #66cc99;
    color: #2a5c45;
}

#mpd.disconnected {
    background-color: #f53c3c;
}

#mpd.stopped {
    background-color: #90b1b1;
}

#mpd.paused {
    background-color: #51a37a;
}

#language {
    background: #000000;
    color: #333333;
    padding: 0 5px;
    margin: 6px 3px;
    min-width: 1px;
}

'';}