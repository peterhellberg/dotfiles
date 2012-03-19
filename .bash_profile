export HISTIGNORE="fg*"
bind '"\C-f": "fg %-\n"'

export PATH=/usr/local/git/bin:/opt/local/bin:/opt/local/sbin:$PATH

RED=$(tput setaf 1)
YELLOW=$(tput bold ; tput setaf 3)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
LIGHT_GRAY=$(tput setaf 7)
WHITE=$(tput bold ; tput setaf 7)
RESET_COLOR=$(tput sgr0)

source ~/.bashrc
shopt -s checkwinsize

PS1='\[$WHITE\]\w \[$YELLOW\]$(parse_git_branch)\[$GREEN\]\n\[$GREEN\]\$\[$RESET_COLOR\] '
export SUDO_PS1="\[$WHITE\]\w \[$YELLOW\]\$(parse_git_branch)\[\e[0;31m\]\n#\[$RESET_COLOR\] "

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
