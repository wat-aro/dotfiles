. ~/.config/fish/aliases.fish

if status --is-login
  . ~/.config/fish/env.fish
end

direnv hook fish | source

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cg __ghq_repository_search
end

function dired
  emacsclient -e "(dired \"$PWD\")"
end

## create emacs env file
perl -wle \
    'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
    PATH > ~/.emacs.d/shellenv.el

# opam configuration
# source /home/wat-aro/.opam/opam-init/init.fish
# eval (opam config env)
