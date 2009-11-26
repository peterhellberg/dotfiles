# Subversion
export SVN_EDITOR='mate -w'

# Git
export GIT_EDITOR="mate -w"
export PATH=$PATH:/usr/local/git/bin/

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}") "
}

# MySQL
export PATH=/usr/local/mysql/bin:$PATH

# ZenTest
export RSPEC=true
export AUTOTEST=true
export AUTOFEATURE=true

# Colors!
export CLICOLOR=1
export LSCOLORS=HxbxfxdxCxegedafahacad

# Aliases
alias ss='script/server'
alias sc='script/console'

# UR
alias assets='ssh -o TCPKeepAlive=no -o ServerAliveInterval=15 root@assets.ur.se'
alias urvalet='cd /Users/peter/Work/Athega/UR/urvalet'
alias ur-thumbnail-generator='cd /Users/peter/Work/Athega/UR/urvalet/ur-thumbnail-generator && mate .'
alias ur-metadata-cache='cd /Users/peter/Work/Athega/UR/urvalet/ur-metadata-cache/trunk && mate .. && ss -p 3001'
alias ur-search-frontend='cd /Users/peter/Work/Athega/UR/urvalet/ur-search-frontend/trunk && mate .. && ss'
alias ur-asset-manager='cd /Users/peter/Work/Athega/UR/urvalet/ur-asset-manager/trunk && mate .. && shotgun ur-asset-manager.rb'
alias ur-schedule-frontend='sudo /opt/nginx/sbin/nginx && cd /Users/peter/Work/Athega/UR/urvalet/ur-broadcast-services/ && mate . && cd /Users/peter/Work/Athega/UR/urvalet/ur-schedule-frontend/trunk/ && mate .. && ss -p 4000'
