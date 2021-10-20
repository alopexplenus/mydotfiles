#!/bin/bash
#   
#    put this into your crontab (change the paths everywhere, do not use ~)
#    * * * * * /path/to/idlecheck.sh >> /path/to/idlelog
#    
#    determine your display number with 
#    echo $DISPLAY
#    and modify the first line according to the result
#   
cd "$( dirname "$0"  )"

export DISPLAY=:0.0
idletime=$(xprintidle)
hour=$(date +%k)
#echo $hour
dayhour=$(date "+%Y-%m-%d %a %H:%M")
#echo $dayhour
state=$(cat work_state)
state_changed=$(date -r work_state "+%s")
time_now=$(date "+%s")
time_delta=$(($time_now-$state_changed))
#echo "state file was changed $time_delta s ago"
#echo "$idletime ms idle, $hour o'clock, current state is $state"
default_state='HOME_OFFICE'
ip=$( ip -4 addr show enp0s31f6 | grep -oP '(?<=inet\s)\d+(\.\d+){2}')
if [[ $ip = '172.20.1' ]]; then
    default_state='IN'
fi



if [[ $state = 'IN' || $state = 'HOME_OFFICE' ]];  then
    if [[ $hour = 12 ]] && (( $idletime > 600000 )); then 
        echo "$dayhour EAT"
        /usr/bin/php client.php EAT
    fi

    if (( $hour < 17 )) && (( $idletime > 600000 )); then 
        echo "$dayhour  PAUSE"
        /usr/bin/php client.php PAUSE
    fi

    if (( $hour > 16 )) && (( $idletime > 600000 )); then 
        echo "$dayhour OUT"
        /usr/bin/php client.php OUT
    fi

    if (( $idletime < 120000 )); then 
            song=$(./whatsong.sh)
            /usr/bin/php client.php $default_state "$song"
    fi
else
    if (( $idletime < 120000 )); then 
            echo "$dayhour $default_state"
            song=$(./whatsong.sh)
            /usr/bin/php client.php $default_state "$song"
    fi
fi
