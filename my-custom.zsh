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
alias reload='exec zsh -l'

export PATH="$PATH:$HOME/.rbenv/bin"
export XDG_CONFIG_HOME=$HOME/.config
export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.exenv/bin
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
export PATH=$PATH:/Users/wat-aro/.local/bin
export PATH=/usr/local/opt/coreutils/libexec/gnubin:${PATH}
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}
export PATH=/usr/local/opt/mysql@5.6/bin:$PATH
export PATH=$HOME/.roswell/bin:$PATH
eval "$(rbenv init - zsh)"
eval "$(exenv init -)"
eval "$(direnv hook zsh)"
eval `opam config env`
export ENHANCD_FILTER=peco
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# for agda
export AGDA_DIR=${HOME}/.agda
alias agda='agda -i . -l standard-library'
alias agdai='agda -I -i . -l standard-library'

# source ~/src/github.com/b4b4r07/enhancd/init.sh

# export PATH=$PATH:/Users/wat-aro/mongodb/bin

# cdしたあとで、自動的に ls する
# function chpwd() { ll }

function git(){hub "$@"}

bindkey -r '^O'

function cd_up() {
    cd ../
    zle reset-prompt
 }
zle -N cd_up
bindkey '^U' cd_up
export PATH="/usr/local/opt/libxml2/bin:$PATH"

source $HOME/.cargo/env
