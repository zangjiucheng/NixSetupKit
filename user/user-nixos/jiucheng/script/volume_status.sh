#!/bin/sh

# Store the output of upower command
# volume_now=$(amixer get Master | grep 'Right:')
volume_now=$(wpctl get-volume @DEFAULT_SINK@)

# Extract relevant information using grep and awk
# state=$(echo "$volume_now" | awk -F'[][]' '{ print $4 }')
# percentage=$(echo "$volume_now" | awk -F'[][]' '{ print $2 }')

percentage=$(echo "$volume_now" | awk '{print $2}')

# if [ $percentage = "0.00" ]; then
#   total_message="Muted"
# else
#   total_message="$(awk "BEGIN {print $percentage * 100}")%"
# fi

total_message="$(awk "BEGIN {print $percentage * 100}")%"

# Print the extracted information
echo $total_message
