#!/usr/bin/zsh

session=$(whoami)
dirname=$(pwd)

# arguments are session name and window name
window_exists(){

    lines_found=$(tmux list-windows -t $1 | grep ": $2" | wc -l)

    #echo "lines found with  $2: $lines_found  \n"
    (($lines_found>0))
}


# Check if the session exists
# window_exists $session "$dirname" || tmux neww  -k -n "$dirname" -t $session: "cd $dirname" 
tmux neww  -k -n "$dirname" -t $session: "cd $dirname; /usr/bin/zsh" 


