ulimit -n 4096

# Have ctrl-s perform i-search (search forward, complements ctrl-r)
stty -ixon

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
export EDITOR='vim'

# Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# NeoVIM
export NVIM_TUI_ENABLE_CURSOR_SHAPE=true

# ooc
export OOC_LIBS=$HOME/Work/ooc
export PATH=$PATH:$OOC_LIBS/sam:$OOC_LIBS/rock/bin

# Go
export GOPATH=$HOME/Go
export CDPATH=.:$GOPATH/src/github.com:$GOPATH/src/golang.org:$GOPATH/src
export PATH=$PATH:$GOPATH/bin
export GOGC=400

if [ -f /usr/local/bin/brew ]; then
  if [ -f `/usr/local/bin/brew --prefix`/etc/bash_completion.d/go_completion.sh ]; then
    source `/usr/local/bin/brew --prefix`/etc/bash_completion.d/go_completion.sh
  fi

  if [ -f `/usr/local/bin/brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
    source `/usr/local/bin/brew --prefix`/etc/bash_completion.d/git-completion.bash
  fi
fi

# Git
export GIT_EDITOR='vim'

# Postgres
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# Rust
export PATH=$PATH:$HOME/.cargo/bin/

# Coreutils gnubin
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

if [ "$TERM" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'
  eval `dircolors ~/.dircolors`
fi

# Functions
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}") "
}

function randomgif {
  giphy random "$@" | xargs curl -s -o '/tmp/giphy.gif' && imgcat '/tmp/giphy.gif'
}

function since {
  echo "$(git l $1..HEAD)" | tac | tail
}

# NPM
export PATH=$PATH:/usr/local/share/npm/bin

# Homebrew
export PATH=/usr/local/sbin:/usr/local/bin:$PATH

# Ruby
export RUBY_GC_HEAP_INIT_SLOTS=1800000  # (10000)
export RUBY_HEAP_FREE_MIN=20000         # (4096)
export RUBY_HEAP_SLOTS_INCREMENT=300000 # (10000)
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1  # (1.8)
export RUBY_GC_MALLOC_LIMIT=85000000    # (8000000)

# Colors!
export CLICOLOR=1
export LSCOLORS=HxbxfxdxCxegedafahacad
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35;40'

# Load aliases
[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# added by travis gem
[ -f /Users/peter/.travis/travis.sh ] && source /Users/peter/.travis/travis.sh
