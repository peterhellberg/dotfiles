ulimit -n 2048

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Bash
export EDITOR='mvim -v -N'

# Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# OCI8 :/
NLS_LANG=American_America.UTF8 export NLS_LANG
# DYLD_LIBRARY_PATH=/opt/oracle/instantclient_11_2 export DYLD_LIBRARY_PATH
ORACLE_HOME=/opt/oracle/instantclient_11_2 export ORACLE_HOME

# ooc
export OOC_LIBS=$HOME/Work/ooc
export PATH=$PATH:$OOC_LIBS/sam

# Go
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin

# Git
source /usr/local/etc/bash_completion.d/git-completion.bash
export GIT_EDITOR='vim'
export PATH=$PATH:/usr/local/git/bin

# Postgres
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin

# Docker
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/peter/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

# Coreutils gnubin
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

if [ "$TERM" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'
  eval `dircolors ~/.dircolors`
fi
# Functions

# Ruby docs
function ref {
  open http://www.omniref.com/?q="$*"
}

# Go docs
function search-godoc {
  curl -s -H 'Accept: text/plain' http://godoc.org/?q="$*"
}

# Control the fan speed of the Macbook Air
# NOTE: Don’t complain if you melt your computer.
function set_fan_speed {
  if [ -z "$1" ]; then min_speed=2000; else min_speed=$1; fi
  if [ -z "$2" ]; then max_speed=6500; else max_speed=$2; fi

  smc=/Applications/smcFanControl.app/Contents/Resources/smc

  min_hex=$(python -c "print hex("$min_speed" << 2)[2:]")
  max_hex=$(python -c "print hex("$max_speed" << 2)[2:]")

  ${smc} -k F0Mn -w ${min_hex}
  ${smc} -k F0Mx -w ${max_hex}
}

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}") "
}

# NPM
export PATH=$PATH:/usr/local/share/npm/bin

# Homebrew
export PATH=/usr/local/sbin:/usr/local/bin:$PATH

# Ruby
export GUARD_NOTIFY=false
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
