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

source ~/.profile
source ~/.bashrc
shopt -s checkwinsize

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

PS1='\[$BLUE\]max \[$WHITE\]\w \[$YELLOW\]$(parse_git_branch)\[$GREEN\]\n\[$GREEN\]\$\[$RESET_COLOR\] '
export SUDO_PS1="\[$BLUE\]max \[$WHITE\]\w \[$YELLOW\]\$(parse_git_branch)\[\e[0;31m\]\n#\[$RESET_COLOR\] "
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

