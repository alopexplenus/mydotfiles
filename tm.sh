#!/usr/bin/zsh

session=$(whoami)
current_dir=$(pwd)

tmux set-option default-path ~ 


# arguments are session name and window name
window_exists(){

    lines_found=$(tmux list-windows -t $1 | grep ": $2" | wc -l)

    #echo "lines found with  $2: $lines_found  \n"
    (($lines_found>0))
}

init_notes(){

    # todo: add KW Heading if file is not there
    # todo: add link in the index file
    # todo: maybe reintroduce the "what have i done" feature
    tmux neww  -k -n notes -t $1: "cd ~/notes; git pull;  /usr/bin/zsh" && ~/weeklynotes.sh  && tmux send-keys "vim index.md" Enter
}

init_session(){
    tmux new-session -d -s $1;
    tmux rename-window -t $1:1 'o_0';
    tmux split-window -v -t $1:1;
    tmux send-keys -t $1:1.1 'vpn' Enter
    tmux send-keys -t $1:1.2 'cd ~/Music' Enter
    
}

# Check if the session exists
tmux has-session -t $session || init_session $session;

window_exists $session "notes" || init_notes $session 

# hosts are configured in ~/.ssh/config
#sed -rn "s/^\s*Host\s+(.*)\s*/\1/ip" ~/.ssh/config | while read host; do 
#   window_exists $session "ssh_$host" || tmux neww  -k -n ssh_$host -t $session: "ssh $host"
#    #((c++)) && ((c==2)) && break
#    break #only one ssh window
#done


#window_exists $session "python" || tmux neww -k -n python -t $session: 'cd; python3' 
#tmux neww -k -n $(basename $current_dir) -t $session: "cd $current_dir; /usr/bin/zsh"

tmux attach -t $session

