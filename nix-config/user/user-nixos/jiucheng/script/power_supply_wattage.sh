#!/bin/sh

power_now=$(cat /sys/class/power_supply/BAT0/uevent | grep POWER_SUPPLY_POWER_NOW | cut -d '=' -f 2)
#
## Convert from microwatts to watts
power_now_watts=$(awk "BEGIN {print $power_now / 1000000}")

echo "$power_now_watts W"


