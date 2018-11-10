abbr --add g "git"
abbr --add be 'bundle exec'
abbr --add r "bin/rails"
alias e 'emacsclient -nw -a ""'
alias e-kill 'emacsclient -e "(kill-emacs)"'
abbr --add psg 'ps aux | grep -v grep | grep'
alias gh 'hub browse (ghq list | peco | cut -d "/" -f 2,3)'
alias onkeyboard "sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/"
alias offkeyboard "sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/"
abbr --add ghc "stack ghc --"
abbr --add ghci "stack ghci"
abbr --add runghc "stack runghc --"
abbr --add runhaskell "stack runghc --"
abbr --add s "stack"
abbr --add sb "stack build"
abbr --add si "stack install"
abbr --add se "stack exec"
abbr --add cat "bat"
balias less "less -r"
alias chrome "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
abbr --add dc "docker-compose"
abbr --add dcr "docker-compose run --rm"
abbr --add dcra "docker-compose run --rm app"
abbr --add dcrar "docker-compose run --rm app bin/rails"
abbr --add dcrae "docker-compose run --rm app bundle exec"
abbr --add dcras "docker-compose run --rm app bundle exec rspec"
abbr --add dce "docker-compose exec"
