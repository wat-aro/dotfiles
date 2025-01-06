# eval "$(rbenv init -)"
alias be='bundle exec'
alias ls='ls --color'
alias la='ls -al --color'
alias grep='grep --color=auto'
alias mkdir='mkdir -p -v'
alias jman='LANG=ja_JP.UTF-8 man'

source /home/wat-aro/.opam/opam-init/init.fish > /dev/null 2> /dev/null
. "$HOME/.cargo/env"
