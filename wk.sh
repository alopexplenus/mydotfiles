#!/bin/bash

# arguments are session name and window name
window_exists(){

    lines_found=$(tmux list-windows -t $1 | grep ": $2[*-]\? (" | wc -l)

    #echo "lines found with  $2: $lines_found  \n"
    (($lines_found>0))
}

makewindow(){
    if [ ! -d ~/projects/$2 ]; then
          echo "Directory ~/projects/$2 does not exist."
          exit 1
    fi

	window_name=$(tmux display-message -p '#W')
	pane_count=$(tmux list-panes | wc -l)


    # jobs_count needs to be set as an environment var as `jobs` does not work in a script
	if [ "$window_name" != "zsh" ] || [ "$pane_count" -gt 1 ] || [ "$jobs_count" -gt 0 ]; then
	  # creating new window
      tmux neww  -k -n $2 -t $1: "cd ~/projects/$2 && ./mystuff/wk.sh;  /usr/bin/zsh" 
	else
	  # renaming current window 
      tmux rename-window $2 && cd ~/projects/$2 && ./mystuff/wk.sh;  /usr/bin/zsh 
	fi

}

session=$(whoami)

if [ "$#" -gt 0  ]; then
    window_exists $session "$1" || makewindow $session "$1"
  else
    # echo "Script has not received any arguments, trying to open project based on current dir"
    if [ -d "mystuff"  ] && [ -f "mystuff/wk.sh"  ]; then
         ./mystuff/wk.sh
    fi
fi

