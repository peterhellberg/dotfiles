if [ "$PS1" ]; then
    if [ -f "$HOME/.ashrc" ]; then
        . "$HOME/.ashrc"
    fi
fi

alias vi='nvim'
alias n='nvim --clean'
alias v='/usr/bin/vi'
alias poweroff='sudo poweroff'

export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/go/bin:$PATH

export GOPATH=$HOME/.local/go
