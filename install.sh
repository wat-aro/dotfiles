#!/bin/bash
for file in .??*
do
    filepath="${PWD}/${file}"
    homefile="${HOME}/${file}"

    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue

    ln -snf $filepath $homefile
done
ln -s ~/dotfiles/private.xml ~/Library/Application\ Support/Karabiner
