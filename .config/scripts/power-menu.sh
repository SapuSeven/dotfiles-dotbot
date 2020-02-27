#!/bin/bash

rofi_command="rofi -width 200 -lines 5 -hide-scrollbar -fixed-num-lines"

options=$'suspend\nhibernate\nlogout\nreboot\nshutdown'

eval i3exit $(echo "$options" | $rofi_command -dmenu -p "")
