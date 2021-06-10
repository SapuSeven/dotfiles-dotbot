#!/bin/bash
# /usr/bin/i3exit

# with openrc use loginctl
[[ $(cat /proc/1/comm) == "systemd" ]] && logind=systemctl || logind=loginctl

COLOR_TEXT=FFFFFFFF
COLOR_BG=222222FF
COLOR_FG=FFB52AFF
COLOR_NONE=00000000
COLOR_RED=E53935FF
COLOR_GREEN=43A047FF

lock() {
	i3lock \
	 --image="$HOME/.scripts/arch-wallpaper-generator/bg.png" -C \
	 --color=$COLOR_BG \
	 --force-clock \
	 --pass-media-keys --pass-screen-keys --pass-power-keys --pass-volume-keys \
	 --radius=250 \
	 --no-modkey-text \
	 --ind-pos="x+w/2:y+h/2+70" \
	 --time-color=$COLOR_TEXT --time-size=50 --time-pos="ix:iy+140" \
	 --date-str="%A, %d.%m.%Y" --date-color=$COLOR_TEXT --date-size=20 --date-pos="tx:ty+40" \
	 --verif-size=80 --wrong-size=80 \
	 --bar-pos="h" --bar-direction=1 \
	 --inside-color=$COLOR_NONE --insidever-color=$COLOR_BG --insidewrong-color=$COLOR_BG \
	 --line-color=$COLOR_BG --ring-width=10 --refresh-rate=3.0 \
	 --ring-color=$COLOR_NONE --ringver-color=$COLOR_NONE --ringwrong-color=$COLOR_NONE \
	 --keyhl-color=$COLOR_FG --bshl-color=$COLOR_RED --separator-color=$COLOR_NONE \
	 --verif-color=$COLOR_FG --wrong-color=$COLOR_RED
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        i3-msg exit
        ;;
    switch_user)
        dm-tool switch-to-greeter
        ;;
    suspend)
        lock && $logind suspend
        ;;
    hibernate)
        lock && $logind hibernate
        ;;
    reboot)
        $logind reboot
        ;;
    shutdown)
        $logind poweroff
        ;;
    *)
        echo "i3exit: missing or invalid argument"
        echo "Try again with: lock | logout | switch_user | suspend | hibernate | reboot | shutdown"
        exit 2
esac

exit 0
