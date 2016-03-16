#!/bin/bash
for file in .??*
do
    filepath="${PWD}/${f}"
    homefile="${HOME}/${f}"

    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue

    ln -snf $filepath $homefile
done
