#!/bin/bash
for f in .??*
do
    filepath="${PWD}/${file}"
    homefile="${HOME}/${file}"
    
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    
    ln -snf $filepath $homefile
done
