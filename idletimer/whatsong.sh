#!/bin/bash

ps -A | grep "\(spotify\)\|\(\<clementine\>\)" | while read processinfo;
do
    #echo $processinfo
    processinfolist=$(echo $processinfo | tr " " "\n")


    for pid in $processinfolist
    do
            #echo "$pid"
            break
    done
    #echo "$pid"

    mypc=$(hostname)
    wmctrl -l -p | grep " $pid " | sed "s/^.*$mypc //"

done;
