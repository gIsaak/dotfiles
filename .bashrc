#!/bin/bash
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load colorscheme from wal if present
#if command -v wal >/dev/null 2>&1 ; then
#    (cat ~/.cache/wal/sequences &)
##    #source ~/.cache/wal/colors-tty.sh
#fi

# Ctrl-o - lf to chage directories
alias lf="lfub"
source "${XDG_CONFIG_HOME:-$HOME/.config}/lf/icons"
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir" || exit
    fi
}
bind '"\C-o":"lfcd\C-m"'

# fzf - bindings and completion
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# Use neovim for vim if present
[ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"

# Add ~/.local/bin and coursier to the PATH
# export PATH="$HOME/.local/share/coursier/bin:$HOME/.local/bin:$HOME/.local/bin/statusbar:$PATH"
export PATH="$PATH:$HOME/.local/bin:$HOME/.local/bin/statusbar:$HOME/.local/share/coursier/bin:$HOME/.local/bin/mattermost:$HOME/.local/bin/julia-1.8.3/bin"

# Start ssh-agent
[ -z "$SSH_AUTH_SOCK" ] && eval $(ssh-agent) && ssh-add ~/.ssh/git/id_rsa

# Defaults programs
export BROWSER="brave"
export BROWSER_INCOGNITO="brave --incognito"
export EDITOR="nvim"
export TERMINAL="alacritty"

# Python environments
export PYVENVS="$HOME/.local/bin/python/venv"
alias pyactivate="source pyactivate"

# Julia
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia"

# Cleanup
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export LESSHISTFILE="-"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export SSB_HOME="$XDG_DATA_HOME/zoom"
export SXRC="${XDG_CONFIG_HOME:-$HOME/.config}/X11/sx/sxrc"

# Set some flags by default
alias \
	cp="cp -iv" \
	mv="mv -iv" \
	rm="rm -vI" \
	bc="bc -ql" \
	mkd="mkdir -pv" \
	cal="cal -m" \

# Colorize commands when possible.
alias \
	ls="ls -hN --color=auto --group-directories-first" \
	grep="grep --color=auto" \
	diff="diff --color=auto" \

# Abbreviations
alias \
	ka="killall" \
	g="git" \
	trem="transmission-remote" \
	sdn="sudo shutdown -h now" \
    rb="sudo reboot" \
	e="$EDITOR" \
	v="$EDITOR" \
	p="sudo pacman" \
	z="zathura"
# PS1='[\u@\h \W]\$ '

# Dotfiles shortcut
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Bookmarks
alias cdbi="cd $HOME/.local/bin"
alias cdwm="cd $HOME/.local/bin/src/dwm"
alias cdsb="cd $HOME/.local/bin/src/dwmblocks"
alias cdwr="cd $HOME/Documents/work"
alias cdbc="cd $HOME/Documents/work/scala-bootcamp-2022"
alias cdde="cd $HOME/Documents/learning/deutsch/abendkurs_kaiserslautern_A_2022/"
