ulimit -n 4096

source ~/.bashrc

export XDG_CONFIG_HOME=~/.config
export EZA_CONFIG_DIR=~/.config/eza

alias ls='eza --icons --group-directories-first --time-style relative --no-user'
alias ll='eza --long --header --icons --git --group-directories-first --time-style long-iso --smart-group --no-user --no-permissions --color-scale all'
alias lr='eza --long --icons --time-style relative -s modified --no-permissions --no-user --color-scale all --git'
alias l='eza --icons -s newest'

complete -F _eza ls
complete -F _eza ll
complete -F _eza lr
complete -F _eza l
