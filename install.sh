#!/bin/bash
for file in .??*
do
    filepath="${PWD}/${file}"
    homefile="${HOME}/${file}"

    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue

    ln -snf $filepath $homefile
done
ln -snf ~/dotfiles/private.xml ~/Library/Application\ Support/Karabiner
ln -snf ~/dotfiles/skk-jisyo.utf8 ~/Library/Application\ Support/AquaSKK
