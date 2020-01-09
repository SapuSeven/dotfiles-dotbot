#!/bin/bash

rofi_command="rofi -width 200 -lines 5 -hide-scrollbar -fixed-num-lines"

options=$'poweroff\nreboot\nlogout\nhibernate\nsuspend'

eval i3exit $(echo "$options" | $rofi_command -dmenu -p "")
