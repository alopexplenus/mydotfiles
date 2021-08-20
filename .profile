# ~/.profile: executed by the command interpreter for login shells
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_logi
# exists
# see /usr/share/doc/bash/examples/startup-files for examples
# the files are located in the bash-doc package
# the default umask is set in /etc/profile; for setting the umas
# for ssh logins, install and configure the libpam-umask package
#umask 02
# if running bas
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
else
    setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll us,ru
    tilda -h &
fi


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


alias joplin="/home/nik/.joplin/Joplin.AppImage"
alias ll="ls -lh"

