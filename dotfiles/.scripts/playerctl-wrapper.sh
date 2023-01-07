#!/usr/bin/env sh

if [ $# -eq 0 ]; then
    exit 1
elif [ $# -eq 2 ];then
    LAST_ACTIVE_PLAYER="$2"
fi

for player in $(playerctl -l); do
    if [ "$(playerctl --player=$player status)" = "Playing" ]; then
        playerctl --player="$player" "$1"
        LAST_ACTIVE_PLAYER="$player"
        echo "$player"
        exit 0
    fi
done

if [ "$(playerctl --player=$LAST_ACTIVE_PLAYER status)" = "Paused" ]; then
    playerctl --player="$LAST_ACTIVE_PLAYER" "$1"
fi

echo "$LAST_ACTIVE_PLAYER"
