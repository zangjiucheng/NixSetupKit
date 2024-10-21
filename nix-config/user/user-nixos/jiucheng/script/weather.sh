#!/bin/sh

# Wait for internet connectivity
sleep 15

# Check for internet connectivity
if ! ping -c 1 aliyun.com > /dev/null 2>&1; then
  echo "Weather: No Internet"
  exit 1
fi

loc=$(curl -s ipinfo.io | grep "loc" | cut -d '"' -f4)
current_weather=$(weather "$loc")

# Extracting details
temperature=$(echo "$current_weather" | grep -oP 'Temperature: \K.*')
# humidity=$(echo "$current_weather" | grep -oP 'Relative Humidity: \K.*')
# wind=$(echo "$current_weather" | grep -oP 'Wind: \K.*')
sky=$(echo "$current_weather" | grep -oP 'Sky conditions: \K.*')

# Echo out the extracted information
echo "Temp: $temperature, Sky: $sky"

