set -x PATH $HOME/.local/bin $PATH
set -x XDG_CONFIG_HOME $HOME/.config $XDG_CONFIG_HOME

set -x ALTERNATE_EDITOR ""
set -x EDITOR "emacsclient -t"
set -x VISUAL "emacsclient -c -a emacs"
set -x GHQ_SELECTOR peco
set -U Z_DATA "$HOME/.z_data"
set -x TERMINAL "gnome-terminal"
set -Ux BROWSER "google-chrome-stable"

set -x PATH ~/.opam/system/bin $PATH
set -x MANPATH "$MANPATH" ~/.opam/system/man
set -x SBT_OPTS "-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"
# set -x PATH ~/.cargo/bin $PATH
