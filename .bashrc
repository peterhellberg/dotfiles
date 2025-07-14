ulimit -n 4096

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

# NeoVIM
export NVIM_TUI_ENABLE_CURSOR_SHAPE=true

# Dokku
export DOKKU_HOST=dokku.c7.se

# Köp
export KOP_ENDPOINT="http://100.68.130.108:12432/rpc/"
alias köp='kop'

# Go
export GOPATH=$HOME/Go
export CDPATH=.:$GOPATH/src/github.com:$GOPATH/src/golang.org:$GOPATH/src:$CDPATH
export PATH=$PATH:$GOPATH/bin
export GOGC=400

# Git
export GIT_EDITOR='nvim'

# Postgres
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# Coreutils gnubin
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

if [ "$TERM" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'
  eval `dircolors ~/.dircolors`
fi

# NPM
export PATH=$PATH:/usr/local/share/npm/bin

# Homebrew
export PATH=/usr/local/sbin:/usr/local/bin:$PATH
export HOMEBREW_NO_ENV_HINTS=true

# User binaries
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.local/bin

# Ruby
export RUBY_GC_HEAP_INIT_SLOTS=1800000  # (10000)
export RUBY_HEAP_FREE_MIN=20000         # (4096)
export RUBY_HEAP_SLOTS_INCREMENT=300000 # (10000)
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1  # (1.8)
export RUBY_GC_MALLOC_LIMIT=85000000    # (8000000)
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Colors!
export CLICOLOR=1
export LSCOLORS=HxbxfxdxCxegedafahacad
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35;40'

# Activate Python3 venv
# [[ -s "$HOME/.venv/bin/activate" ]] && source ~/.venv/bin/activate

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Functions
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}") "
}

function since {
  echo "$(git l $1..HEAD)" | tac | tail
}

# Load aliases
[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Load organization specific config
# [[ -s "$HOME/.orgs/<name>.sh" ]] && source "$HOME/.orgs/<name>.sh"
export HISTIGNORE="fg*"

eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -t 1 ]
then
  bind '"\C-f": "fg %-\n"'

  RED=$(tput setaf 1)
  YELLOW=$(tput bold ; tput setaf 3)
  GREEN=$(tput setaf 2)
  BLUE=$(tput setaf 4)
  LIGHT_GRAY=$(tput setaf 7)
  WHITE=$(tput bold ; tput setaf 7)
  RESET_COLOR=$(tput sgr0)

  shopt -s checkwinsize

  [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

  PS1='\[$BLUE\]max \[$WHITE\]\w \[$YELLOW\]$(parse_git_branch)\[$GREEN\]\n\[$GREEN\]\$\[$RESET_COLOR\] '
  export SUDO_PS1="\[$BLUE\]max \[$WHITE\]\w \[$YELLOW\]\$(parse_git_branch)\[\e[0;31m\]\n#\[$RESET_COLOR\] "
fi

export NATS_URL=nats://tiny:4222

export PATH=/usr/local/git/bin:/opt/local/bin:/opt/local/sbin:$PATH

eval "$(ssh-agent -s)" &>/dev/null

export OLLAMA_HOST=0.0.0.0
export WASMVISION_PROCESSORS_DIR=$HOME/.local/wasmvision/processors/

source $HOME/.wash/wash.bash
