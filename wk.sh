#!/bin/bash

# arguments are session name and window name
window_exists(){

    lines_found=$(tmux list-windows -t $1 | grep ": $2[*-]\? (" | wc -l)

    #echo "lines found with  $2: $lines_found  \n"
    (($lines_found>0))
}

session=$(whoami)
window_exists $session "$1" || tmux neww  -k -n $1 -t $session: "cd ~/projects/$1 && ./mystuff/wk.sh;  /usr/bin/zsh" 


