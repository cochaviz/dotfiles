#!/bin/bash

STATUS="$(playerctl status)"

playerctl-wrapper.sh pause "$(cat $HOME/.last_active_player || echo "spotify")" > "$HOME/.last_active_player"

env XSECURELOCK_AUTH_FOREGROUND_COLOR="$(xrdb -get color11)" XSECURELOCK_NO_COMPOSITE=1 XSECURELOCK_PASSWORD_PROMPT=kaomoji xsecurelock

if [[ $STATUS = "Playing" ]]; then
    playerctl-wrapper.sh play "$(cat $HOME/.last_active_player || echo "spotify")" > "$HOME/.last_active_player"
fi
