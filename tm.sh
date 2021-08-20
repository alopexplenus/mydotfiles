#!/usr/bin/zsh

session="nikita"

# Check if the session exists, discarding output
# We can check $? for the exit status (zero for success, non-zero for failure)
tmux has-session -t $session 2>/dev/null

if [ $? != 0 ]; then

    # Set up your session
    tmux new-session -d -s nikita 
    tmux new-window -n mydotfiles -t nikita: 'cd ~/mydotfiles; git pull && vim .; /usr/bin/zsh '

    #tmux new-window -n nadmozg -t nikita: 'cd ~/nadmozg.wiki; git pull && vim .; /usr/bin/zsh '
    tmux new-window -n nadmozg -t nikita: 'jp' 

    # work is configured in ~/.ssh/config
    tmux new-window -n calypso -t nikita: 'ssh work -t "export HISTFILE=~/.nik_history; tmux  -L nikita new-session -A -s nikita"'

fi

# Attach to created session
tmux attach-session -t $session
