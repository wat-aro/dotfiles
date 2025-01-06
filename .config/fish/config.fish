. ~/.config/fish/aliases.fish
. ~/.config/fish/env.fish

eval (/opt/homebrew/bin/brew shellenv)
if test -n "$MANPATH[1]"; set --global --export MANPATH '' $MANPATH; end;
if not contains "/opt/homebrew/share/info" $INFOPATH; set --global --export INFOPATH "/opt/homebrew/share/info" $INFOPATH; end;
eval (mise activate fish)

if status --is-login
  . ~/.config/fish/env.fish
end

direnv hook fish | source

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cg __ghq_repository_search
  bind "\u00ed" kill-word
end

function dired
  emacsclient -e "(dired \"$PWD\")"
end

## create emacs env file
perl -wle \
    'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
    PATH > ~/.emacs.d/shellenv.el
