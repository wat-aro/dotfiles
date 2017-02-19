# eval "$(rbenv init -)"
alias be='bundle exec'
alias ls='ls -G'
alias ll='ls -alG'
alias grep='grep --color=auto'
alias emacs='/usr/local/Cellar/emacs/24.5/bin/emacs -nw'
alias onkeyboard="sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/"
alias offkeyboard="sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/"

## Homebrew ##
export HOMEBREW_EDITOR='emacs -nw'

## create emacs env file
# perl -wle \
#      'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
#      PATH > ~/.emacs.d/shellenv.el
