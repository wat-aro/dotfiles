# Add yourself some shortcuts to projects you often work on
# Example:
#
# brainstormr=/Users/robbyrussell/Projects/development/planetargon/brainstormr
#
alias ll='ls -al'
alias be='bundle exec'
export PATH="$PATH:$HOME/.rbenv/bin"
export GTAGSLABEL=pygments
eval "$(rbenv init - zsh)"
alias onkeyboard="sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/"
alias offkeyboard="sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/"
function git(){hub "$@"}
export XDG_CONFIG_HOME=$HOME/.config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
export GOPATH=$HOME/golang
export PATH=$GOPATH/bin:$PATH
alias ghqlist='cd $(ghq list -p | peco)'
alias ghqhub='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
export PATH="$HOME/.exenv/bin:$PATH"
eval "$(exenv init -)"
source ~/src/github.com/b4b4r07/enhancd/init.sh
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
alias emax="emacsclient -t"
alias semac="sudo emacsclient -t"
alias e='emacsclient -nw -a ""'
alias e-kill='emacsclient -e "(kill-emacs)"'
# ## create emacs env file
# perl -wle \
#      'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
#      PATH > ~/.emacs.d/shellenv.el

# cdしたあとで、自動的に ls する
# function chpwd() { ll }
