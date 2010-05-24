export PATH=/usr/local/git/bin:/opt/local/bin:/opt/local/sbin:$PATH

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GRAY="\[\033[0;37m\]"
WHITE="\[\033[1;37m\]"

export PS1="$WHITE\w $YELLOW\$(parse_git_branch)$GREEN\$$LIGHT_GRAY "
export SUDO_PS1="$WHITE\w $YELLOW\$(parse_git_branch)$RED#$LIGHT_GRAY "

source ~/.bashrc
