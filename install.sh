#!/bin/bash
for file in .??*
do
    filepath="${PWD}/${file}"
    homefile="${HOME}/${file}"

    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue
    [[ "$file" == ".gitignore" ]] && continue

    ln -snf $filepath $homefile
done
