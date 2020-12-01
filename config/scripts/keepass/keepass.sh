#!/bin/bash
cd "$(dirname "$0")" || exit

copy() {
  python keepass.py info "$selection" "$@" | xclip -selection c
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


selection=$(python keepass.py list | rofi -dmenu -i -p "Search")

if [[ ${selection} == "" ]]; then
  exit
fi

options=$(cat << END
Copy Username
Copy Password
Copy OTP Code
$(echo -e "$(python keepass.py info "$selection" custom)" | while read line; do echo "Copy ${line}"; done)
Perform Auto-Type
END
)

action=$(echo -e "$options" | rofi -dmenu -p "$selection")

if [[ ${action} == "Copy Username" ]]; then
  copy user
elif [[ ${action} == "Copy Password" ]]; then
  copy pass
elif [[ ${action} == "Copy OTP Code" ]]; then
  copy otp
elif [[ ${action} == "Perform Auto-Type" ]]; then
  autotype
elif [[ ${action} == "Copy "* ]]; then
  copy custom "${action/#Copy /}"
elif [[ ${action} == "" ]]; then
  exit
fi
