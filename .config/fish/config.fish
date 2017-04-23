balias git hub
balias g hub
balias be 'bundle exec'
alias e 'emacsclient -nw -a ""'
alias e-kill 'emacsclient -e "(kill-emacs)"'
alias psg 'ps aux | grep -v grep | grep'
alias gh 'hub browse (ghq list | peco | cut -d "/" -f 2,3)'
alias onkeyboard "sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/"
alias offkeyboard "sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/"
alias ghc "stack ghc --"
alias ghci "stack ghci"
alias runghc "stack runghc --"
alias runhaskell "stack runghc --"
alias s "stack"
alias sb "stack build"
alias si "stack install"
alias se "stack exec"

set -x PATH $HOME/.rbenv/bin $PATH
set -x PATH $HOME/.exenv/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH /usr/local/opt/libxml2/bin $PATH
set -x XDG_CONFIG_HOME $HOME/.config $XDG_CONFIG_HOME

set -x ALTERNATE_EDITOR ""
set -x EDITOR "emacsclient -t"
set -x VISUAL "emacsclient -c -a emacs"
set -x GHQ_SELECTOR peco

eval (opam config env)

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end
