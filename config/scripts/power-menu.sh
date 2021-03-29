#!/bin/bash

rofi_command="rofi -width 200 -lines 6 -hide-scrollbar -fixed-num-lines"

options=$'suspend\nhibernate\nlock\nlogout\nreboot\nshutdown'

eval ~/.config/scripts/i3exit.sh $(echo "$options" | $rofi_command -dmenu -p "")
