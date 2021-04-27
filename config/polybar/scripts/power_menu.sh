#!/bin/bash

MENU="$(rofi -sep "|" -dmenu -i -p 'System' -location 5 -yoffset -40 -width 15 -hide-scrollbar -line-padding 4 -padding 15 -lines 6 -font "Fantasque Sans Mono 10" -color-normal "#1F1F1F, #FFFFFF, #000000, #43a047, #FFFFFF" -color-window "#1F1F1F, #1F1F1F" <<< " Lock| Logout| Suspend| Hibernate| Reboot| Shutdown")"
            case "$MENU" in
                *Lock) i3exit.sh lock;;
                *Logout) i3exit.sh logout;;
                *Suspend) i3exit.sh suspend;;
                *Hibernate) i3exit.sh hibernate;;
                *Reboot) i3exit.sh reboot;;
                *Shutdown) i3exit.sh shutdown
            esac
