# Bash
export EDITOR='mvim -v -N'

# Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Perl
export PERLBREW_ROOT=~/.perl5/perlbrew
export PERLBREW_HOME=~/.perlbrew
source ${PERLBREW_ROOT}/etc/bashrc

# Git
source /usr/local/git/contrib/completion/git-completion.bash
export GIT_EDITOR='mvim -v -N -f -c "au VimLeave * !open -a Terminal"'
export PATH=$PATH:/usr/local/git/bin/

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
export NODE_PATH='/usr/local/lib/node'
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc'

# Aliases
alias vim='mvim -n -v -N'
alias mvim='mvim -n -N -c "set noballooneval"'
alias mongod='mongod run --config /usr/local/Cellar/mongodb/2.0.2-x86_64/mongod.conf'
alias solr_example=' solr /usr/local/Cellar/solr/3.5.0/libexec/example/solr/'
alias elasticsearch_start='elasticsearch -f -D es.config=/usr/local/Cellar/elasticsearch/0.19.1/config/elasticsearch.yml'
alias default-redis-server='redis-server /usr/local/etc/redis.conf'
alias ur-redis-server='redis-server /Users/peter/Work/Athega/UR/ur-redis/ur-redis.conf'
alias ur-redis-cli='redis-cli -s /tmp/ur-redis.sock'
alias :q='logout'
alias c7='cd ~/Work/Code7/GitHub/c7/c7.se/'
alias jullunch='cd ~/Work/Athega/GitHub/jullunch/'
alias shrug.se='cd ~/Work/Code7/GitHub/c7/shrug.se'
alias brug.se='cd ~/Work/Code7/GitHub/c7/brug.se'

alias gource_custom='gource --hide mouse,filenames,bloom,progress -s 2 -i 0 --auto-skip-seconds 0.1 --logo /Users/peter/athega_logo.png --logo-offset "20x20" --camera-mode overview -900x600 --font-colour FF6600 --multi-sampling --font-size 24'

# Git related
alias g='git'
alias gst='git status'
alias gl='git pull'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gd='git diff | mate'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
