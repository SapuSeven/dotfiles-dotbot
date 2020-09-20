#!/bin/bash

MENU="$(rofi -sep "|" -dmenu -i -p 'System' -location 5 -yoffset -40 -width 15 -hide-scrollbar -line-padding 4 -padding 15 -lines 6 -font "Fantasque Sans Mono 10" -color-normal "#1F1F1F, #FFFFFF, #000000, #43a047, #FFFFFF" -color-window "#1F1F1F, #1F1F1F" <<< " Lock| Logout| Suspend| Hibernate| Reboot| Shutdown")"
            case "$MENU" in
                *Lock) ~/.config/scripts/lock.sh;;
                *Logout) i3exit logout;;
                *Suspend) i3exit suspend;;
                *Hibernate) i3exit hibernate;;
                *Reboot) i3exit reboot;;
                *Shutdown) i3exit shutdown
            esac
