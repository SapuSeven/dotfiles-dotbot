#!/usr/bin/env bash

# Starts a scan of available broadcasting SSIDs
# nmcli dev wifi rescan

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FIELDS=SSID,SECURITY
POSITION=0
YOFF=0
XOFF=0
FONT="DejaVu Sans Mono 10"


# Get mouse position and screen dimensions
eval $(xdotool getmouselocation --shell)
MONITOR=$(expr $SCREEN + 1)
SCREENWIDTH=$(xrandr --current | grep '*' |  awk -v line="$MONITOR" 'NR==line{print $1}' | cut -d 'x' -f1)

if [ -r "$DIR/config" ]; then
	source "$DIR/config"
elif [ -r "$HOME/.config/rofi/wifi" ]; then
	source "$HOME/.config/rofi/wifi"
else
	echo "WARNING: config file not found! Using default values."
fi

CONSTATE=$(nmcli -fields WIFI g)

if [[ "$CONSTATE" =~ "enabled" ]]; then
    echo connected

    NETWORKS=$(nmcli --fields "$FIELDS" device wifi list | awk 'NR>1' | sed '/^--/d')
    # For some reason rofi always approximates character width 2 short... hmmm
    RWIDTH=$(($(echo "$NETWORKS" | head -n 1 | awk '{print length($0); }')+2))
    # Dynamically change the height of the rofi menu
    LINENUM=$(echo "$NETWORKS" | wc -l)
    # Gives a list of known connections so we can parse it later
    KNOWNCON=$(nmcli connection show)

    CURRSSID=$(LANGUAGE=C nmcli -t -f active,ssid dev wifi | awk -F: '$1 ~ /^yes/ {print $2}')

    if [[ ! -z $CURRSSID ]]; then
        HIGHLINE=$(echo  "$(echo "$NETWORKS" | awk -F "[  ]{2,}" '{print $1}' | grep -Fxn -m 1 "$CURRSSID" | awk -F ":" '{print $1}') - 1" | bc )
    fi

	TOGGLE="toggle off"
elif [[ "$CONSTATE" =~ "disabled" ]]; then
	TOGGLE="toggle on"
fi

if [[ "$CONSTATE" =~ "enabled" ]]; then
    if [ "$LINENUM" -gt 8 ]; then
        LINENUM=8
    fi
    
    CHENTRY=$(echo -e "$NETWORKS\nmanual\n$TOGGLE" | uniq -u | rofi -dmenu -p "Wi-Fi SSID" -lines "$LINENUM" -a "$HIGHLINE" -location "$POSITION" -yoffset "$YOFF" -xoffset -$(expr $SCREENWIDTH - $X - 50) -font "$FONT" -width -"$RWIDTH")
elif [[ "$CONSTATE" =~ "disabled" ]]; then
    CHENTRY=$(echo -e "$TOGGLE" | rofi -dmenu -p "Wi-Fi SSID" -lines 1 -location "$POSITION" -yoffset "$YOFF" -xoffset -$(expr $SCREENWIDTH - $X - 50) -font "$FONT" -width -32)
fi


CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $1}')
#echo "$CHSSID"

# If the user inputs "manual" as their SSID in the start window, it will bring them to this screen
if [ "$CHENTRY" = "manual" ] ; then
	# Manual entry of the SSID and password (if appplicable)
	MSSID=$(echo "enter the SSID of the network (SSID,password)" | rofi -dmenu -p "Manual Entry" -font "$FONT" -lines 1)
	# Separating the password from the entered string
	MPASS=$(echo "$MSSID" | awk -F "," '{print $2}')

	#echo "$MSSID"
	#echo "$MPASS"

	# If the user entered a manual password, then use the password nmcli command
	if [ "$MPASS" = "" ]; then
		nmcli dev wifi con "$MSSID"
	else
		nmcli dev wifi con "$MSSID" password "$MPASS"
	fi

elif [ "$CHENTRY" = "toggle on" ]; then
	nmcli radio wifi on

elif [ "$CHENTRY" = "toggle off" ]; then
	nmcli radio wifi off

else

	# If the connection is already in use, then this will still be able to get the SSID
	if [ "$CHSSID" = "*" ]; then
		CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $3}')
	fi

	# Parses the list of preconfigured connections to see if it already contains the chosen SSID. This speeds up the connection process
	if [[ $(echo "$KNOWNCON" | grep "$CHSSID") = "$CHSSID" ]]; then
		nmcli con up "$CHSSID"
	else
		if [[ "$CHENTRY" =~ "WPA2" ]] || [[ "$CHENTRY" =~ "WEP" ]]; then
			WIFIPASS=$(echo "if connection is stored, hit enter" | rofi -dmenu -p "password: " -lines 1 -font "$FONT" )
		fi
		nmcli dev wifi con "$CHSSID" password "$WIFIPASS"
	fi

fi
