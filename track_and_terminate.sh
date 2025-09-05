#!/bin/bash

# CONFIG
CHECK_PERIOD=1
MAX_TIME=40
COUNTER_FILE="$HOME/.time_counter"
COUNTER_LOG="$HOME/.counter_log"

USER_NAME="$(whoami)"

# Check if user has an active session
if ! who | grep -q "^$USER_NAME "; then
     echo "User $USER_NAME is not logged in. Exiting."
     exit 1
fi


# Ensure counter file exists
if [ ! -f "$COUNTER_FILE" ]; then
    echo "$(date +%F) 0 " > "$COUNTER_FILE"
fi

# Read current date and counter
read -r stored_date stored_minutes < "$COUNTER_FILE"
current_date=$(date +%F)
current_time=$(date +%T)

# Reset if date changed
if [ "$stored_date" != "$current_date" ]; then
    stored_minutes=0
    echo "$current_date $stored_minutes" > "$COUNTER_FILE"
fi

stored_minutes=$((stored_minutes + CHECK_PERIOD))
echo "$current_date $stored_minutes" > "$COUNTER_FILE"
echo "$current_date $current_time User active. Time: $stored_minutes/$MAX_TIME min" >> "$COUNTER_LOG"
echo "$current_date $current_time User active. Time: $stored_minutes/$MAX_TIME min"


# Kill if over max
if [ "$stored_minutes" -ge "$MAX_TIME" ]; then
#notify-send "Und Tschüss" "Das waren 20 Minuten. Zeit sich zu entspannen"
pkill -KILL -u "$USER"
fi

