#!/bin/sh

# Define the path to the battery directory
BATTERY_DIR="/sys/class/power_supply/BAT0"

# Check if the battery directory exists
if [ -d "$BATTERY_DIR" ]; then
    # Read the battery state
    state=$(cat "$BATTERY_DIR/status")

    # Read the battery capacity
    percentage=$(cat "$BATTERY_DIR/capacity")

    total_message="CS: $state, BL: $percentage%"

    # Print the extracted information
    echo $total_message
else
    echo "Battery directory not found!"
fi
