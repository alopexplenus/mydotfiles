#!/usr/bin/zsh

session=$(whoami)



monthly_note=$(date +"%Y-%m.md")


# Check if the session exists, discarding output
# We can check $? for the exit status (zero for success, non-zero for failure)
#

tmux has-session -t $session ||  tmux new-session -d -s $session;

tmux neww  -k -n tickets -t $session: 'cd ~/Sync/obsidian/; vim tickets/tickets.md ;  /usr/bin/zsh ' 
tmux neww  -k -n notes -t $session: "cd ~/Sync/obsidian/; vim Nadmozg/index.md Nadmozg/$monthly_note -p;  /usr/bin/zsh " 

 # hosts are configured in ~/.ssh/config
sed -rn "s/^\s*Host\s+(.*)\s*/\1/ip" ~/.ssh/config | while read host; do 
    echo $host;
    tmux neww  -k -n ssh_$host -t $session: "ssh $host -t \"export HISTFILE=~/.bash_history_$session; tmux  -L $session new-session -A -s $session \""
    ((c++)) && ((c==2)) && break
done


tmux neww -k -n python -t $session: 'cd; python3' 

tmux attach -t $session

# todo: check if window exists, with output from list-windows
#➜  ~ tmux list-windows -t nik
#1: ~#- (1 panes) [80x24] [layout b262,80x24,0,0,5] @5
#2: python* (1 panes) [80x24] [layout b263,80x24,0,0,6] @6 (active)

