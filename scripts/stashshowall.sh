#!/bin/sh
#  stashshowall.sh
# Finds where you stashed a file 
# Usage : stashshowall.sh | grep "stash\|some-file"
# 
for stash in `git stash list | sed 's/\(\w*\)\:.*/\1/'`
do
    echo
    echo "$stash"
    git stash show $stash
done

