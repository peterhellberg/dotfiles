export HISTIGNORE="fg*"

source ~/.profile

# Eza bash completion
. "/home/peter/Code/GitHub/eza-community/eza/completions/bash/eza"

alias ls='eza --icons --group-directories-first --time-style relative --no-user'
alias ll='eza --long --header --icons --git --group-directories-first --time-style long-iso --smart-group --no-user --no-permissions --color-scale all'
alias lr='eza --long --icons --time-style relative -s modified --no-permissions --no-user --color-scale all --git'
alias l='eza --icons -F -s newest'

complete -F _eza ls
complete -F _eza ll
complete -F _eza lr
complete -F _eza l
