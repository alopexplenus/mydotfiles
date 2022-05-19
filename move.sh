#!/bin/bash
if [ $1 -eq 2 ]
then
	POS1=1280
	POS2=0
else
	POS1=0
	POS2=0
fi
/usr/bin/xdotool windowmove `/usr/bin/xdotool getwindowfocus` $POS1 $POS2
exit 0
