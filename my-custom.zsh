alias ll='ls -al'
alias be='bundle exec'
alias e='emacsclient -nw -a ""'
alias e-kill='emacsclient -e "(kill-emacs)"'
alias psg='ps aux | grep -v grep | grep'
alias g='git'
alias gl='cd $(ghq list -p | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias onkeyboard="sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/"
alias offkeyboard="sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/"
alias ghc="stack ghc --"
alias ghci="stack ghci"
alias runghc="stack runghc --"
alias runhaskell="stack runghc --"
alias s="stack"
alias sb="stack build"
alias si="stack install"
alias se="stack exec"

export PATH="$PATH:$HOME/.rbenv/bin"
export XDG_CONFIG_HOME=$HOME/.config
export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.exenv/bin
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
export PATH=$PATH:/Users/wat-aro/.local/bin

eval "$(rbenv init - zsh)"
eval "$(exenv init -)"
eval "$(direnv hook zsh)"
eval `opam config env`
source ~/src/github.com/b4b4r07/enhancd/init.sh

# export PATH=$PATH:/Users/wat-aro/mongodb/bin

# cdしたあとで、自動的に ls する
function chpwd() { ll }

function git(){hub "$@"}

bindkey -r '^O'

function cd_up() {
    cd ../
    zle reset-prompt
 }
zle -N cd_up
bindkey '^U' cd_up
