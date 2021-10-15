#!/bin/bash

session=$(whoami)


tmux send-keys -t $session:tickets ":e!" ENTER
