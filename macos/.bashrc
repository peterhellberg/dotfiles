if [ -t 1 ]
then
  # Have ctrl-s perform i-search (search forward, complements ctrl-r)
  stty -ixon
fi

# don't put duplicate lines or lines starting with space in the history.
# also erase all duplicates
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1500
HISTFILESIZE=3500

# Bash
export EDITOR='nvim'

# Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_LANG=en_US.UTF-8
export LANG=en_US.UTF-8

GPG_TTY=$(tty)
export GPG_TTY

export LIBRARY_PATH="$LIBRARY_PATH:/opt/homebrew/lib"

# Go
export GOPATH=$HOME/Go
export CDPATH=.:$GOPATH/src/github.com:$GOPATH/src/golang.org:$GOPATH/src:$CDPATH
export PATH=$PATH:$GOPATH/bin
export GOGC=400

# Git
export GIT_EDITOR='nvim'

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# Coreutils gnubin
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

if [ "$TERM" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'
  eval `dircolors ~/.dircolors`
fi

# Homebrew
export PATH=/usr/local/sbin:/usr/local/bin:$PATH
export HOMEBREW_NO_ENV_HINTS=true

# User binaries
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.local/bin

# Colors!
export CLICOLOR=1
export LSCOLORS=HxbxfxdxCxegedafahacad
export GREP_COLOR='1;35;40'

# Activate Python3 venv
# [[ -s "$HOME/.venv/bin/activate" ]] && source ~/.venv/bin/activate

function since {
  echo "$(git l $1..HEAD)" | tac | tail
}

function run {
  if [ $# -eq 0 ]; then
    runme --project .
  else
    runme --project . run "$@"
  fi
}

# Load aliases
[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Load organization specific config
# [[ -s "$HOME/.orgs/<name>.sh" ]] && source "$HOME/.orgs/<name>.sh"
####################################################################

export HISTIGNORE="fg*"

eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -t 1 ]; then
  bind '"\C-f": "fg %-\n"'

  RED='\[\033[0;31m\]'
  GREEN='\[\033[0;32m\]'
  YELLOW='\[\033[0;33m\]'
  BLUE='\[\033[0;34m\]'
  WHITE='\[\033[0;37m\]'
  RESET_COLOR='\[\033[0m\]'
    
  EXIT='$(ec=$?; ((ec)) && printf "\033[0;31m[%d]\033[0m " "$ec")'

  shopt -s checkwinsize

  [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && 
    . "/opt/homebrew/etc/profile.d/bash_completion.sh"

  if [ -f /opt/homebrew/etc/bash_completion.d/git-prompt.sh ]; then
    source /opt/homebrew/etc/bash_completion.d/git-prompt.sh
  
    PS1='$(ec=$?; ((ec)) && printf "\[\033[0;31m\][%d]\[\033[0m\] " "$ec")'

    if [ "$EUID" -eq 0 ]; then
      PS1+="${YELLOW}max ${WHITE}\w ${YELLOW}\$(__git_ps1 '(%s)')\n${RED}\\\$${RESET_COLOR} "
    else    
      PS1+="${BLUE}max ${WHITE}\w ${YELLOW}\$(__git_ps1 '(%s)')\n${GREEN}\\\$${RESET_COLOR} "
    fi

    export PS1
  fi
fi

export PATH=/usr/local/git/bin:/opt/local/bin:/opt/local/sbin:$PATH

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  eval "$(ssh-agent -s)" > /dev/null
fi

export DOKKU_HOST=dokku.c7.se
export OLLAMA_HOST=0.0.0.0

export NATS_URL=nats://tiny:4222

# Köp
export KOP_ENDPOINT="http://tiny:12432/rpc/"
alias köp='kop'
