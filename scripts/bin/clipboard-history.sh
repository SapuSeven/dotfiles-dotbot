clipster -o -n 10 | rofi -dmenu -p "Paste" | xclip -selection c
xdotool key ctrl+v
clipster -r
