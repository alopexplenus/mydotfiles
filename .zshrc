# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/nik/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
 HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git 
    thefuck 
    symfony 
    composer
    poetry
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#source ~/.bin/tmuxinator.zsh

alias l='ls -lA'
alias ll="ls -lh"
alias la="ls -la"

# tm script to create or recreate tmux windows
alias tm="~/tm.sh"
# wk script to wake up project, opent in new tmux window and runs project specific wake up script
alias wk="~/wk.sh"

alias xo="xdg-open"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gs="git stash"
alias gsa="git stash apply"
alias gdo="~/opendiff.sh"

# taken from this post: https://andrew-quinn.me/fzf/
alias vfn='vim $(fzf)'
alias vfb='vim $(rg . | fzf | cut -d ":" -f 1)'

alias pm="./run pre-merge"

alias ww="cd ~/notes && ~/weeklynote.sh && tmux rename-window notes; vim index.md;"

session=$(whoami)
sed -rn "s/^\s*Host\s+(.*)\s*/\1/ip" ~/.ssh/config | while read host; do 
    alias $host="ssh $host -t \"export HISTFILE=~/.bash_history_$session; tmux  -L $session new-session -A -s $session \""
done

eval $(thefuck --alias)

if [ "$TERM_PROGRAM" != tmux  ]; then
    if [ "$TMUX_LAUNCHED" != "launched"  ]; then
        export TMUX_LAUNCHED="launched"
        tm
    fi
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Autocomplete for wake command, wip
source ~/.wk_autocomplete.sh


# git -f is bad
git() {
    if [[ $@ == 'push -f'* || $@ == 'push --force '*   ]]; then
        echo Hey stupid, use --force-with-lease instead
    else
        command git "$@"
    fi
}

