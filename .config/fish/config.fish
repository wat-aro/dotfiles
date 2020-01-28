. ~/.config/fish/aliases.fish

if status --is-login
  . ~/.config/fish/env.fish
end

eval (direnv hook fish)

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cg __ghq_repository_search
  bind \eg __ghq_browse_github
end

function dired
  emacsclient -e "(dired \"$PWD\")"
end

## create emacs env file
perl -wle \
    'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
    PATH > ~/.emacs.d/shellenv.el

# opam configuration
source /home/wat-aro/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
eval (opam config env)
