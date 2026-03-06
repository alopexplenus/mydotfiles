#!/bin/bash

# CONFIG
CHECK_PERIOD=60  # Check every minute (in seconds)
STATE_DIR="/var/lib/time_limit"
LOG_FILE="/var/log/time_limit.log"

# Ensure state directory exists
mkdir -p "$STATE_DIR"

# Function to get user's time limit
get_user_limit() {
    local username=$1
    local limit_file="$STATE_DIR/${username}.limit"
    
    # If limit file doesn't exist, user has no limit (excluded)
    if [ ! -f "$limit_file" ]; then
        echo ""
        return
    fi
    
    # Read the limit from file
    cat "$limit_file"
}

# Function to send notification to a specific user
send_notification() {
    local username=$1
    local title=$2
    local message=$3
    
    # Find user's display and DBUS session
    local user_id=$(id -u "$username")
    local display=$(who | grep "^$username " | awk '{print $2}' | head -n1)
    
    # Try to find DBUS_SESSION_BUS_ADDRESS
    local dbus_addr=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u "$username" -n)/environ 2>/dev/null | cut -d= -f2-)
    
    if [ -n "$dbus_addr" ]; then
        sudo -u "$username" DISPLAY=":0" DBUS_SESSION_BUS_ADDRESS="$dbus_addr" notify-send "$title" "$message" 2>/dev/null || true
    fi
}

# Function to process a single user
process_user() {
    local username=$1
    local counter_file="$STATE_DIR/${username}.counter"
    local user_log="$STATE_DIR/${username}.log"
    
    # Get user's time limit
    local max_time=$(get_user_limit "$username")
    
    # If no limit is set, skip this user
    if [ -z "$max_time" ]; then
        return
    fi
    
    # Ensure counter file exists
    if [ ! -f "$counter_file" ]; then
        echo "$(date +%F) 0" > "$counter_file"
    fi
    
    # Read current date and counter
    read -r stored_date stored_minutes < "$counter_file"
    current_date=$(date +%F)
    current_time=$(date +%T)
    
    # Reset if date changed
    if [ "$stored_date" != "$current_date" ]; then
        stored_minutes=0
        echo "$current_date $stored_minutes" > "$counter_file"
    fi
    
    stored_minutes=$((stored_minutes + 1))
    echo "$current_date $stored_minutes" > "$counter_file"
    
    local log_message="$current_date $current_time User $username active. Time: $stored_minutes/$max_time min"
    echo "$log_message" >> "$user_log"
    echo "$log_message" >> "$LOG_FILE"
    
    # Send notification to user
    send_notification "$username" "Achtung Zeitlimit" "Zeit verbraucht: $stored_minutes/$max_time Min"
    
    # Kill if over max
    if [ "$stored_minutes" -ge "$max_time" ]; then
        echo "$current_date $current_time TERMINATING user $username (exceeded $max_time minutes)" >> "$LOG_FILE"
        sleep 2  # Give notification time to display
        pkill -KILL -u "$username"
    fi
}

# Main loop
echo "Starting time_limit service at $(date)" >> "$LOG_FILE"

while true; do
    # Get list of currently logged-in users
    logged_in_users=$(who | awk '{print $1}' | sort -u)
    
    # Process each logged-in user
    for username in $logged_in_users; do
        # Skip root and system users
        if [ "$username" != "root" ] && id "$username" &>/dev/null; then
            process_user "$username"
        fi
    done
    
    # Wait for CHECK_PERIOD seconds before next check
    sleep "$CHECK_PERIOD"
done

