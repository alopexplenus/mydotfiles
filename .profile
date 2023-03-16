# ~/.profile: executed by the command interpreter for login shells
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_logi
# exists
# see /usr/share/doc/bash/examples/startup-files for examples
# the files are located in the bash-doc package
# the default umask is set in /etc/profile; for setting the umas
# for ssh logins, install and configure the libpam-umask package
#umask 02


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


#add symfony binary to path
export PATH="$HOME/.symfony/bin:$PATH"
export PATH="/usr/local/share/python3:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# launch available dropdown terminal
if command -v guake &> /dev/null
then
    guake &
else
    if command -v tilda &> /dev/null
    then
        tilda -h  &
    fi
fi

if command -v vim &> /dev/null
then
    export EDITOR=$(which vim)
else
    if command -v vi &> /dev/null
    then
        export EDITOR=$(which vi)
    fi
fi

# keyboard layout
setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll us,ru

