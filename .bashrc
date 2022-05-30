# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
    *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(mcfly init bash)"

eval "$(thefuck --alias)"

function sshssh() {     _sesdir="/home/ryan/sshlogs/";     mkdir -p "${_sesdir}" &&     ssh "$@" 2>&1 | tee -a "${_sesdir}/$(date +%Y%m%d).log";     }

HISTSIZE=5000

# Here is a sample function to display the most recent file in a certain directory:

function latest_file()
{
    local f latest
    for f in "${1:-.}"/*
    do
        [[ $f -nt $latest ]] && latest="$f"
    done
    printf '%s\n' "$latest"
}

# This function displays the oldest file in a certain directory:

function oldest_file()
{
    local f oldest
    for file in "${1:-.}"/*
    do
        [[ -z $oldest || $f -ot $oldest ]] && oldest="$f"
    done
    printf '%s\n' "$oldest"
}

alias myip="curl http://ipecho.net/plain; echo"

# Get the weather
weather() { curl -s --connect-timeout 3 -m 5 http://wttr.in/"$1"; }

# NEOFETCH
neofetch(){ curl -sL https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch | bash; }
neofetch

#! /usr/bin/env bash
# If you source this file, it will set WTTR_PARAMS as well as show weather.

# WTTR_PARAMS is space-separated URL parameters, many of which are single characters that can be
# lumped together. For example, "F q m" behaves the same as "Fqm".
if [[ -z "$WTTR_PARAMS" ]]; then
    # Form localized URL parameters for curl
    if [[ -t 1 ]] && [[ "$(tput cols)" -lt 125 ]]; then
        WTTR_PARAMS+='n'
    fi 2> /dev/null
    for _token in $( locale LC_MEASUREMENT ); do
        case $_token in
            1) WTTR_PARAMS+='m' ;;
            2) WTTR_PARAMS+='u' ;;
        esac
    done 2> /dev/null
    unset _token
    export WTTR_PARAMS
fi

wttr() {
    local location="${1// /+}"
    command shift
    local args=""
    for p in $WTTR_PARAMS "$@"; do
        args+=" --data-urlencode $p "
    done
    curl -fGsS -H "Accept-Language: ${LANG%_*}" $args --compressed "wttr.in/${location}"
}

# wttr "$@"
weather "$@"

#partial command history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

eval "$(jump shell)"

# Put the line below in ~/.bashrc or ~/bash_profile:
#
#   eval "$(jump shell bash)"
#
# The following lines are autogenerated:

__jump_prompt_command() {
    local status=$?
    jump chdir && return $status
}

__jump_hint() {
    local term="${COMP_LINE/#j /}"
    echo \'$(jump hint "$term")\'
}

j() {
    local dir="$(jump cd "$@")"
    test -d "$dir"  && cd "$dir" || exit
}

[[ "$PROMPT_COMMAND" =~ __jump_prompt_command ]] || {
    PROMPT_COMMAND="__jump_prompt_command;$PROMPT_COMMAND"
}

complete -o dirnames -C '__jump_hint' j

# Update everything
updateUpgrade() {
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get dist-upgrade -y
    sudo apt-get autoremove -y
}
