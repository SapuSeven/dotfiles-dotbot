export PATH=$HOME/.local/bin:$HOME/.scripts/bin:$HOME/.config/rofi/bin:$PATH
[ -f $HOME/.themes/current/colors.env ] && source $HOME/.themes/current/colors.env

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
        exec startx
fi
