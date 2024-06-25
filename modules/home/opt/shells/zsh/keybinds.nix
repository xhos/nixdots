{ config, lib, ... }:

{
	programs.zsh.initExtra = ''
		bindkey "^H" backward-word
		bindkey '^J' beginning-of-line
		bindkey '^K' end-of-line
		bindkey "^L" forward-word

		bindkey "^U" backward-kill-line
		bindkey "^D" kill-line

		bindkey "^W" kill-word
		# bindkey "^W" backward-kill-word
	'';
}