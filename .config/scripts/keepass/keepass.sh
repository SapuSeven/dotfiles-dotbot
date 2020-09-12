#!/bin/bash
cd "$(dirname "$0")" || exit

copy() {
  python keepass.py info "$selection" "$1" | xclip -selection c
}

autotype() {
  echo "auto type $selection"

  user=$(python keepass.py info "$selection" user)
  pass=$(python keepass.py info "$selection" pass)

  xdotool type "$user"
  xdotool key Tab
  xdotool type "$pass"
  xdotool key Return
}

options=(
  "Copy Username"
  "Copy Password"
  "Copy OTP Code"
  "Perform Auto-Type"
)

selection=$(python keepass.py list | rofi -dmenu -i -p "Search")

if [[ ${selection} == "" ]]; then
  exit
fi

action=$(printf '%s\n' "${options[@]}" | rofi -dmenu -p "$selection")

if [[ ${action} == "Copy Username" ]]; then
  copy user
elif [[ ${action} == "Copy Password" ]]; then
  copy pass
elif [[ ${action} == "Copy OTP Code" ]]; then
  copy otp
elif [[ ${action} == "Perform Auto-Type" ]]; then
  autotype
elif [[ ${action} == "" ]]; then
  exit
fi

#python keepass.py info "$selection"
