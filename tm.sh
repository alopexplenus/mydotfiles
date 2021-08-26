#!/usr/bin/zsh

session=$(whoami)

# Check if the session exists, discarding output
# We can check $? for the exit status (zero for success, non-zero for failure)
tmux has-session -t $session 2>/dev/null

if [ $? != 0 ]; then

    tmux new-session -d -s $session -n mydotfiles 'cd ~/mydotfiles; git pull && vim .; /usr/bin/zsh '

    #tmux new-window -n nadmozg -t nikita: 'cd ~/nadmozg.wiki; git pull && vim .; /usr/bin/zsh '
    #tmux new-window -n nadmozg -t $session: 'jp' 

    # hosts are configured in ~/.ssh/config
    sed -rn "s/^\s*Host\s+(.*)\s*/\1/ip" ~/.ssh/config | while read host; do tmux new-window -n ssh_$host -t $session: "ssh $host -t \"export HISTFILE=~/.bash_history_$session; tmux  -L $session new-session -A -s $session \""; done

    tmux new-window -n python -t $session: 'python3' 

fi

# Attach to created session
tmux attach-session -t $session
