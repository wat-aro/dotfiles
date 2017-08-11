set -x PATH $HOME/.local/bin $PATH
set -x PATH /usr/local/opt/libxml2/bin $PATH
set -x XDG_CONFIG_HOME $HOME/.config/peco/config.json $XDG_CONFIG_HOME

set -x ALTERNATE_EDITOR ""
set -x EDITOR "emacsclient -t"
set -x VISUAL "emacsclient -c -a emacs"
set -x GHQ_SELECTOR peco
set -U Z_DATA "$HOME/.z_data"

set -x PATH ~/.opam/system/bin $PATH
set -x MANPATH "$MANPATH" ~/.opam/system/man
set -x SBT_OPTS "-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"
