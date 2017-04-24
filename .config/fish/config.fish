. ~/.config/fish/aliases.fish

if status --is-login
  . ~/.config/fish/env.fish
end

eval (opam config env)
eval (direnv hook fish)

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cx\cf peco_recentd
  bind \cg __ghq_crtl_g
end

function dired
  emacsclient -e "(dired \"$PWD\")"
end
