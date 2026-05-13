# profile settings for zsh


if [ "$TERM_PROGRAM" != tmux  ]; then
    if [ "$TMUX_LAUNCHED" != "launched"  ]; then
        export TMUX_LAUNCHED="launched"
        tm
    fi
fi


# Autocomplete for wake command
source ~/.wk_autocomplete.sh

# Autocomplete for run command
source ~/.run_autocomplete.sh

# my binz
export PATH=~/.local/bin:$PATH

# custom user-owned dir for global node packages
export PATH=~/.npm-global/bin:$PATH

# opencode
export PATH=/home/nik/.opencode/bin:$PATH

export EDITOR='vim'
