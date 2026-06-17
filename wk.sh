#!/bin/bash

# arguments are session name and window name
window_exists(){

    lines_found=$(tmux list-windows -t $1 | grep ": $2[*-]\? (" | wc -l)

    #echo "lines found with  $2: $lines_found  \n"
    (($lines_found>0))
}

ensure_mystuff(){
    local proj_dir="$1"
    mkdir -p "$proj_dir/mystuff"
    if [ ! -f "$proj_dir/mystuff/wk.sh" ]; then
        cat > "$proj_dir/mystuff/wk.sh" <<'EOF'
#!/bin/bash
# project-specific workspace setup
EOF
        chmod +x "$proj_dir/mystuff/wk.sh"
    fi
}

makewindow(){
    local proj_dir=~/projects/$2
    if [ ! -d "$proj_dir" ]; then
        read -p "Directory $proj_dir does not exist. Create it? [y/N] " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            mkdir -p "$proj_dir"
        else
            exit 1
        fi
    fi

    ensure_mystuff "$proj_dir"

	window_name=$(tmux display-message -p '#W')
	pane_count=$(tmux list-panes | wc -l)


    # jobs_count needs to be set as an environment var as `jobs` does not work in a script
	if [ "$window_name" != "zsh" ] || [ "$pane_count" -gt 1 ] || [ "$jobs_count" -gt 0 ]; then
	  # creating new window
      tmux neww  -k -n $2 -t $1: "cd $proj_dir && ./mystuff/wk.sh;  /usr/bin/zsh" 
	else
	  # renaming current window 
      tmux rename-window $2 && tmux send-keys "cd $proj_dir && ./mystuff/wk.sh" Enter
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

