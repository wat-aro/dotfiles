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
ln -snf ~/dotfiles/my-custom.zsh ~/.oh-my-zsh/custom/
ln -snf ~/dotfiles/my-custom.zsh ~/my-custom.zsh
ln -snf ~/Dropbox/.ssh ~/.ssh
