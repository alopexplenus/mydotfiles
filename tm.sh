#!/usr/bin/zsh

session=$(whoami)

# Check if the session exists, discarding output
# We can check $? for the exit status (zero for success, non-zero for failure)
tmux has-session -t $session 2>/dev/null

if [ $? != 0 ]; then

    # Set up your session
    tmux new-session -d -s $session 
    tmux new-window -n mydotfiles -t $session: 'cd ~/mydotfiles; git pull && vim .; /usr/bin/zsh '

    #tmux new-window -n nadmozg -t nikita: 'cd ~/nadmozg.wiki; git pull && vim .; /usr/bin/zsh '
    tmux new-window -n nadmozg -t $session: 'jp' 

    # work is configured in ~/.ssh/config
    tmux new-window -n calypso -t $session: "ssh work -t \"export HISTFILE=~/.bash_history_$session; tmux  -L $session new-session -A -s $session \""

fi

# Attach to created session
tmux attach-session -t $session
