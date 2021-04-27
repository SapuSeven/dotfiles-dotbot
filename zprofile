export PATH=$HOME/.local/bin:$HOME/.scripts/bin:$PATH

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
        exec startx
fi
