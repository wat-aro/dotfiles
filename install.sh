#!/bin/bash
for file in .??*
do
    filepath="${PWD}/${f}"
    homefile="${HOME}/${f}"
    
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    
    ln -snf $filepath $homefile
done
