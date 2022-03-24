#!/usr/bin/zsh

session=$(whoami)
monthly_note=$(date +"%Y-%m.md")

# arguments are session name and window name
window_exists(){

    lines_found=$(tmux list-windows -t $1 | grep ": $2" | wc -l)

    #echo "lines found with  $2: $lines_found  \n"
    (($lines_found>0))
}


# Check if the session exists
tmux has-session -t $session ||  tmux new-session -d -s $session;

# window_exists $session "tickets" || tmux neww  -k -n tickets -t $session: 'cd ~/projects/tickettool/tickets/; vim tickets.md ;  /usr/bin/zsh ' 
window_exists $session "notes" || tmux neww  -k -n notes -t $session: "cd ~/Sync/obsidian/Nadmozg/; vim index.md $monthly_note -p;  /usr/bin/zsh " 

 # hosts are configured in ~/.ssh/config
sed -rn "s/^\s*Host\s+(.*)\s*/\1/ip" ~/.ssh/config | while read host; do 
    #echo "ssh_$host";
    window_exists $session "ssh_$host" || tmux neww  -k -n ssh_$host -t $session: "ssh $host -t \"export HISTFILE=~/.bash_history_$session; tmux  -L $session new-session -A -s $session \""
    ((c++)) && ((c==2)) && break
done


window_exists $session "python" || tmux neww -k -n python -t $session: 'cd; python3' 

tmux attach -t $session

