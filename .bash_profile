export PATH="~/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export MANPATH="/usr/share/man:$MANPATH"
export MANPATH="~/.opam/default/man:$MANPATH"
export MANPATH="~/.opam/system/man:$MANPATH"

test -r ~/.bashrc && . ~/.bashrc
if [ -e /home/wat-aro/.nix-profile/etc/profile.d/nix.sh ]; then . /home/wat-aro/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
