#!/usr/bin/zsh

session=$(whoami)
weekly_note=$(date +"%Y-KW%V.md")
weekly_note_heading=$(date +"# KW%V\n")
previous_weekly_note=$(date +"%Y-KW%V.md" -d "7 days ago")

if [[ ! -f ~/notes/$weekly_note ]]; then
    echo "$weekly_note_heading" > ~/notes/$weekly_note
    echo $(date +"# %d.%m\n") >> ~/notes/$weekly_note

    echo "\n\n# What have I done?!\n" >> ~/notes/$previous_weekly_note
    cat ~/notes/todos.md | grep "\[[xX]\]" >> ~/notes/$previous_weekly_note
    cat ~/notes/f/todos.md | grep "\[[xX]\]" >> ~/notes/$previous_weekly_note

fi

current_dir=$(pwd)

tmux set-option default-path ~ 


# arguments are session name and window name
window_exists(){

    lines_found=$(tmux list-windows -t $1 | grep ": $2" | wc -l)

    #echo "lines found with  $2: $lines_found  \n"
    (($lines_found>0))
}


# Check if the session exists
tmux has-session -t $session ||  tmux new-session -d -s $session;

# window_exists $session "tickets" || tmux neww  -k -n tickets -t $session: 'cd ~/projects/tickettool/tickets/; vim tickets.md ;  /usr/bin/zsh ' 
window_exists $session "notes" || tmux neww  -k -n notes -t $session: "cd ~/notes; vim $weekly_note ;  /usr/bin/zsh " 

# hosts are configured in ~/.ssh/config
#sed -rn "s/^\s*Host\s+(.*)\s*/\1/ip" ~/.ssh/config | while read host; do 
#   window_exists $session "ssh_$host" || tmux neww  -k -n ssh_$host -t $session: "ssh $host"
#    #((c++)) && ((c==2)) && break
#    break #only one ssh window
#done


#window_exists $session "python" || tmux neww -k -n python -t $session: 'cd; python3' 
tmux neww -k -n $(basename $current_dir) -t $session: "cd $current_dir; /usr/bin/zsh"

tmux attach -t $session

