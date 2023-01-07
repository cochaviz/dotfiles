#!/bin/bash

# Kill al instances of hideIt
for PID in $(ps aux | grep hideIt.sh | grep polybar | grep -oP '^zohar\s+\K(\w+)\s'); do
	kill -9 "$PID"
done


"$HOME"/.config/polybar/launch.sh "$1"

sleep 3

# Remove top padding
bspc config top_padding 0

# Run hideIt
exec hideIt.sh --class '^polybar$' --direction top -p -"$2" -H -S &> /dev/null
