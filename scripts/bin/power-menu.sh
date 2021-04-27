#!/bin/bash

rofi_command="rofi -width 200 -lines 6 -hide-scrollbar -fixed-num-lines"
options=$'suspend\nhibernate\nlock\nlogout\nreboot\nshutdown'

selection=$(echo "$options" | $rofi_command -dmenu -p "")

[ $? == 0 ] && i3exit.sh $selection
