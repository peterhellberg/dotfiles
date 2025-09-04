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

PS1='\[$WHITE\]\w \[$YELLOW\]$(parse_git_branch)\[$GREEN\]\n\[$GREEN\]\$\[$RESET_COLOR\] '
export SUDO_PS1="\[$WHITE\]\w \[$YELLOW\]\$(parse_git_branch)\[\e[0;31m\]\n#\[$RESET_COLOR\] "

alias ls='eza --icons --group-directories-first --time-style relative --no-user'
alias ll='eza --long --header --icons --git --group-directories-first --time-style long-iso --smart-group --no-user --no-permissions --color-scale all'
alias lr='eza --long --icons --time-style relative -s modified --no-permissions --no-user --color-scale all --git'
alias l='eza --icons -F -s newest'

complete -F _eza ls
complete -F _eza ll
complete -F _eza lr
complete -F _eza l
