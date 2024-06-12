#!/bin/sh

# Store the output of upower command
volume_now=$(amixer get Master | grep 'Right:' )

# Extract relevant information using grep and awk
state=$(echo "$volume_now" | awk -F'[][]' '{ print $4 }')
percentage=$(echo "$volume_now" | awk -F'[][]' '{ print $2 }')


if [ $state = "off" ]; then
    total_message="Muted"
else
    total_message="$percentage"
fi

# Print the extracted information
echo $total_message
