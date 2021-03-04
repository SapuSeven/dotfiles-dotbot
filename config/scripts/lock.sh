#!/bin/bash

export DISPLAY=:0

# Multilockscreen:
#multilockscreen -l

# i3lock:
#old
#i3lock --blur=10 --clock --indicator --insidecolor=1F1F1FFF --insidevercolor=1F1F1FFF --insidewrongcolor=1F1F1FFF --ringcolor=1F1F1FFF --ringvercolor=43A047FF --ringwrongcolor=E53935FF --line-uses-inside --keyhlcolor=43A047FF --bshlcolor=43A047FF --separatorcolor=1F1F1FFF --verifcolor=FFFFFFFF --wrongcolor=FFFFFFFF --timecolor=FFFFFFFF --datecolor=FFFFFFFF

COLOR_TEXT=FFFFFFFF
COLOR_BG=222222FF
COLOR_FG=FFB52AFF
COLOR_NONE=00000000
COLOR_RED=E53935FF
COLOR_GREEN=43A047FF

i3lock \
 --image="$HOME/.config/scripts/arch-wallpaper-generator/bg.png" -C \
 --color=$COLOR_BG \
 --force-clock \
 --pass-media-keys --pass-screen-keys --pass-power-keys --pass-volume-keys \
 --radius=250 --no-modkeytext\
 --indpos="x+w/2:y+h/2+70" \
 --timecolor=$COLOR_TEXT --timesize=50 --timepos="ix:iy+140" \
 --datestr="%A, %d.%m.%Y" --datecolor=$COLOR_TEXT --datesize=20 --datepos="tx:ty+40" \
 --verifsize=80 --wrongsize=80 \
 --bar-position="h" --bar-direction=1 \
 --insidecolor=$COLOR_NONE --insidevercolor=$COLOR_BG --insidewrongcolor=$COLOR_BG \
 --linecolor=$COLOR_BG --ring-width=10 --refresh-rate=3.0 \
 --ringcolor=$COLOR_NONE --ringvercolor=$COLOR_NONE --ringwrongcolor=$COLOR_NONE \
 --keyhlcolor=$COLOR_FG --bshlcolor=$COLOR_RED --separatorcolor=$COLOR_NONE \
 --verifcolor=$COLOR_FG --wrongcolor=$COLOR_RED \
#--no-verify
