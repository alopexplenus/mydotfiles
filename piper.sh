#!/bin/bash
#
ssh -D 9999 $1 2>/dev/null
echo DONE
sleep 5 
echo "RESTARTING SCRIPT"


"/home/nik/piper.sh" $1 && exit

