#!/usr/bin/env sh

# Arbitrary but unique message id
msgId="991049"

# Query amixer for the current volume and whether or not the speaker is muted
VOLUME=$(pactl list sinks | grep -oPze "(?s)Sink #$(get_active_sonk.sh sinks)\n.*?Volume.*?\K(\d+)%" | head -c -2)
MUTED=$(pactl list-sinks | grep -oPze "(?s)index: $(get_ctive_sonk.sh sinks)\n.*?muted:\s+\K(\w+)")

echo $MUTED
echo $VOLUME

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"

if [[ $VOLUME == 0 ]] || [[ $MUTED == "yes" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i /home/zohar/Pictures/mute-2-24.png -r "$msgId" "Volume muted" 
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i /home/zohar/Pictures/volume-up-4-24.png -r "$msgId" \
    -h int:value:"$VOLUME" "Volume ${VOLUME}%"
fi
