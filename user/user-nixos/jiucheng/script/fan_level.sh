#!/bin/bash

# Path to the fan status file
FAN_STATUS_FILE="/proc/acpi/ibm/fan"

# Function to get the fan level
get_fan_level() {
    cat $FAN_STATUS_FILE | grep level | awk '{print $2}'
}

# Get the current fan level
FAN_LEVEL=$(get_fan_level)

# Light blue color
COLOR="#ADD8E6"

# Output the fan level and color for i3blocks
echo "Fan Level: $FAN_LEVEL"
echo $COLOR

