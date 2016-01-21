ulimit -n 4096

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

# NeoVIM
export NVIM_TUI_ENABLE_TRUE_COLOR=true
export NVIM_TUI_ENABLE_CURSOR_SHAPE=true

# ooc
export OOC_LIBS=$HOME/Work/ooc
export PATH=$PATH:$OOC_LIBS/sam:$OOC_LIBS/rock/bin

# Go
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin
export GO15VENDOREXPERIMENT=0
export GOGC=400
if [ -f `brew --prefix`/etc/bash_completion.d/go_completion.sh ]; then
  source `brew --prefix`/etc/bash_completion.d/go_completion.sh
fi

# Git
if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
  source `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi
export GIT_EDITOR='nvim'

# Postgres
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin

# Rust
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/lib/rustlib/x86_64-apple-darwin/lib/
export RUST_SRC_PATH=$HOME/Work/src/rustc-1.5.0/src

# Docker
if [ $(id -un) == "peter" ]; then
  if which docker-machine >/dev/null; then
    if [ $(docker-machine status default) == "Running" ]; then
      eval "$(docker-machine env default)"
      export DOCKER_TLS_VERIFY=1
    fi
  fi
fi

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
