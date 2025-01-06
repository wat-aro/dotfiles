#!/bin/bash
for file in .??*
do
    filepath="${HOME}/dotfiles/${file}"
    homefile="${HOME}/${file}"

    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".config" ]] && continue
    
    ln -snf $filepath $homefile
done

ln -snf ${HOME}/dotfiles/.config ${HOME}/.config
