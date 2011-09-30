# Bash
export EDITOR='mvim -v -N -f --nomru -c "au VimLeave * !open -a Terminal"'

# Subversion
export SVN_EDITOR='mvim -f'

# Perl
source ~/.perl5/perlbrew/etc/bashrc

# Git
source /usr/local/git/contrib/completion/git-completion.bash
export GIT_EDITOR='mvim -v -N -f -c "au VimLeave * !open -a Terminal"'
export PATH=$PATH:/usr/local/git/bin/

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

function entitlements_generic_tester {
  if [ -z "$1" ]; then
    SESSION_TOKEN='51123fd0647bfb103ad6bc8c67e6ffa10d8aa8cf'
  else
    SESSION_TOKEN=$1
  fi

  echo ""
  curl -s --insecure --user-agent \
    "Videnskab+D 1.41 (iPad; iPhone OS 3.2.2; da_DK; illvid-dk; 1.42; f0d2ad5a7d471c67a8bf2fbb4f71b7b07154f5ed)" \
    "http://api.magplus.dev/v3/brands/generic-tester/entitlements?session_token=$SESSION_TOKEN" | json -i
  echo ""
}

# OpenCV
export PYTHONPATH="/usr/local/lib/python2.6/site-packages/:$PYTHONPATH"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/Cellar/opencv/2.2/lib/pkgconfig"

# NPM
export PATH=$PATH:/usr/local/share/npm/bin

# Homebrew
export PATH=/usr/local/sbin:/usr/local/bin:$PATH

# Opt
export PATH=$PATH:/opt/bin

# MySQL
export PATH=/usr/local/mysql/bin:$PATH

# JRuby
export PATH=$PATH:/opt/jruby/bin

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
alias mongod='mongod run --config /usr/local/Cellar/mongodb/2.0.0-x86_64/mongod.conf'
alias elasticsearch_start='elasticsearch -f -D es.config=/usr/local/Cellar/elasticsearch/0.17.1/config/elasticsearch.yml'
alias :q='logout'

# Bonnier
alias s='rake spec'

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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
