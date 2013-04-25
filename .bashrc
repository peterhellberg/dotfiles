ulimit -n 1024

# Bash
export EDITOR='mvim -v -N'

# Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# Go
export GOROOT=/usr/local/Cellar/go/1.0.3
export GOPATH=$GOPATH:/Users/peter/Go/

export PATH=$PATH:${GOPATH//://bin:}/bin

# Git
source /usr/local/etc/bash_completion.d/git-completion.bash
export GIT_EDITOR='mvim -v -N -f -c "au VimLeave * !open -a Terminal"'
export PATH=$PATH:/usr/local/git/bin

# Functions

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

function wiki {
 dig +short txt $1.wp.dg.cx
}

function blunderbuss {
  if [ -z "$1" ]; then
    PORT=9393
  else
    PORT=$1
  fi

  IP=`ifconfig | grep -m 1 broadcast | awk '{print $2}'`
  shotgun -s thin -o $IP -p $PORT
}

function sass-watch {
  if [ -z "$3" ]; then
    SASS_IN='all.scss'
    CSS_OUT='all.css'
    SASS_WATCH_PATH='.'
  else
    SASS_IN=$1
    CSS_OUT=$2
    SASS_WATCH_PATH=$3
  fi

kicker -s -e "sass --scss --style compressed $SASS_IN $CSS_OUT" $SASS_WATCH_PATH
}

# NPM
export PATH=$PATH:/usr/local/share/npm/bin

# Homebrew
export PATH=/usr/local/sbin:/usr/local/bin:$PATH

# MySQL
export PATH=/usr/local/mysql/bin:$PATH

# Ruby
export GUARD_NOTIFY=false
export RUBY_HEAP_MIN_SLOTS=800000       #(10000)
export RUBY_HEAP_FREE_MIN=100000        # (4096)
export RUBY_HEAP_SLOTS_INCREMENT=300000 # (10000)
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1  # (1.8)
export RUBY_GC_MALLOC_LIMIT=36000000    # (8000000)

# Rubinius
export RBXOPT=-X19

# Python
export PATH="/usr/local/share/python:${PATH}"

# ZenTest
export RSPEC=true
export AUTOTEST=true
export AUTOFEATURE=true

# Colors!
export CLICOLOR=1
export LSCOLORS=HxbxfxdxCxegedafahacad

# JavaScript
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc'

# Aliases
alias vim='mvim -n -v -N'
alias mvim='mvim -n -N -c "set noballooneval"'
alias mongod='mongod run --config /usr/local/Cellar/mongodb/2.2.0-x86_64/mongod.conf'
alias solr_ss='/usr/local/Cellar/solr/3.6.0/bin/solr /usr/local/Cellar/solr/3.5.0/libexec/ss/solr/'
alias solr_example='/usr/local/Cellar/solr/3.6.0/bin/solr /usr/local/Cellar/solr/3.5.0/libexec/example/solr/'
alias elasticsearch_start='elasticsearch -f -D es.config=/usr/local/Cellar/elasticsearch/0.20.6/config/elasticsearch.yml'
alias default-redis-server='redis-server /usr/local/etc/redis.conf'
alias pg_start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg_stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias :q='logout'
alias tags='ctags -R --exclude=.git --exclude=log --exclude=*.min.js *'
alias rake_with_verbose_tests="rake TESTOPTS='-v'"
alias irb='pry || irb'
alias ls='ls -F'
alias pbqr='pbpaste | qrencode -o /tmp/qr.png -s 10 && qlmanage -p /tmp/qr.png &> /dev/null'

## Athega
alias jullunch='cd ~/Work/Athega/GitHub/jullunch/'

## Code7
alias c7='cd ~/Work/Code7/GitHub/c7/c7.se/'
alias hashids.rb='cd ~/Work/Code7/GitHub/hashids.rb/'
alias shrug.se='cd ~/Work/Code7/GitHub/c7/shrug.se'
alias brug.se='cd ~/Work/Code7/GitHub/c7/brug.se'
alias forks='cd ~/Work/Code7/GitHub/forks'

## TV4
alias tv4-redis-server='redis-server /Users/peter/Work/Athega/TV4/tv4-redis/tv4-redis.conf'
alias tv4-redis-cli='redis-cli -s /tmp/tv4-redis.sock'
alias tv4='cd ~/Work/Athega/TV4/GitHub/www.tv4.se/'
alias tv4play='cd ~/Work/Athega/TV4/GitHub/tv4play/'

## UR
# alias ur-redis-server='redis-server /Users/peter/Work/Athega/UR/ur-redis/ur-redis.conf'
# alias ur-redis-cli='redis-cli -s /tmp/ur-redis.sock'
# alias ss-frontend='cd ~/Work/Athega/UR/GitHub/ss-frontend'
# alias announcer-schedule='cd ~/Work/Athega/UR/GitHub/announcer-schedule'
# alias vision-web-interface='cd ~/Work/Athega/UR/GitHub/vision-web-interface'
# alias ur-search-api='cd ~/Work/Athega/UR/GitHub/ur-search-api'
# alias google-analytics-harvester='cd ~/Work/Athega/UR/GitHub/google-analytics-harvester'
# alias analytics='cd ~/Work/Athega/UR/GitHub/ur-analytics-dashboard'

# Git related
alias g='git'
alias gst='git status'
alias gl='git pull'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gd='git diff'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
