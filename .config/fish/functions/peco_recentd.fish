function peco_recentd
  z -l | peco --rcfile ~/.config/peco/config.json | awk '{ print $2 }' | read recentd
  cd $recentd
end
