#!/bin/zsh
export PATH=$HOME/.local/bin:$HOME/.scripts/bin:$HOME/.config/rofi/bin:/opt/android-sdk/build-tools/33.0.0:$PATH
[ -f $HOME/.themes/current/colors.env ] && source $HOME/.themes/current/colors.env

#if [ -f .zshenv ]; then
#    source .zshenv
#fi

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec sway
fi
