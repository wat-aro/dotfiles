alias git hub
alias g git
alias e="emacsclient -nw -a ''"
alias be="bundle exec"
alias onkeyboard="sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/"
alias offkeyboard="sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/"

set -x PATH $HOME/.rbenv/bin $PATH
set -x PATH $HOME/.rbenv/shims $PATH
set -x PATH /usr/local/opt/openssl/bin $PATH
set -x PATH $HOME/.exenv/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x EXENV_ROOT $HOME/.exenv
set -x EDITOR "emacsclient -t"
set -x EDITOR "emacsclient -c -a emacs"

eval (opam config env)
