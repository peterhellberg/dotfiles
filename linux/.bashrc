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
HISTSIZE=1500
HISTFILESIZE=3500

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Bash
export EDITOR='nvim -u ~/.minimal.vimrc'

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
#force_color_prompt=yes

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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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

export PATH=/usr/local/go/bin:$PATH
export PATH=/home/peter/.local/bin:$PATH

# Git
export GIT_EDITOR='nvim -u $HOME/.dotfiles/linux/nvim/init.lua'

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Code
export CODE=$HOME/Code
export GITHUB=$CODE/GitHub
export CDPATH=.:$GITHUB/peterhellberg:$GITHUB/c7:$GITHUB/athega

# Go
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin
export GOGC=400

# Load aliases
[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Functions
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}") "
}

function gl {
  git log $(git describe --tags --abbrev=0)..HEAD --reverse --pretty=format:'- [X] %s'
}

function gri {
  local branch="$1"

  git rebase --exec 'git commit --amend --no-edit -n -S' -i ${branch}
}

function run {
  if [ $# -eq 0 ]; then
    runme --project .
  else
    runme --project . run "$@"
  fi
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$HOME/.rvm/bin:$PATH"

if [[ $TILIX_ID ]]; then
  source /etc/profile.d/vte-2.91.sh
fi

export PATH=$PATH:$HOME/Go/bin

# Zig
export PATH=$PATH:$HOME/.local/zig

# NX
export PATH=$PATH:/usr/NX/bin/

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"

if [[ $- == *i* ]]
then
  # Colors
  RED=$(tput setaf 1)
  YELLOW=$(tput bold ; tput setaf 3)
  GREEN=$(tput setaf 2)
  BLUE=$(tput setaf 4)
  LIGHT_GRAY=$(tput setaf 7)
  WHITE=$(tput bold ; tput setaf 7)
  RESET_COLOR=$(tput sgr0)

  if [[ -v CONTAINER_ID ]]; then 
    export PS1='\[$RED\]${CONTAINER_ID}\[$RESET_COLOR\] on \[$YELLOW\]tiny \[$WHITE\]\w \[$YELLOW\]$(parse_git_branch)\[$GREEN\]\n\[$GREEN\]\$\[$RESET_COLOR\] '
  else
    export PS1='\[$YELLOW\]tiny \[$WHITE\]\w \[$YELLOW\]$(parse_git_branch)\[$GREEN\]\n\[$GREEN\]\$\[$RESET_COLOR\] '
  fi
  
  # export PS1="$([[ ! -z "${UPTERM_ADMIN_SOCKET}"  ]] && echo -e '\xF0\x9F\x86\x99 ')$PS1" # Add an emoji
fi

export VIRTUAL_ENV_DISABLE_PROMPT=1

export OLLAMA_HOST=prime.feist-gopher.ts.net:11434
export NATS_URL="nats://localhost:4222"

export WASMVISION_MODELS_DIR="/home/peter/.config/wasmvision/models"
export WASMVISION_PROCESSORS_DIR="/home/peter/.config/wasmvision/processors"

# Set keyboard rate (default: 660 25)
[ -v DISPLAY ] && xset r rate 300 30

# Wasmer
export WASMER_DIR="/home/peter/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# wash completions -d $HOME/.wash bash
source $HOME/.wash/wash.bash
. "/home/peter/.deno/env"
