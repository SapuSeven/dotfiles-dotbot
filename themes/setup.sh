#!/bin/sh

THEME=$1

if [ ! -d ~/.themes/$THEME/ ]; then
    echo "Invalid theme: \"$THEME\""
    exit 1
fi

if [ ! -f ~/.config/i3/config.base ]; then
    mv ~/.config/i3/config ~/.config/i3/config.base
fi


# i3 color theming
if [ -f ~/.themes/$THEME/i3.colors ]; then
    cat ~/.config/i3/config.base ~/.themes/$THEME/i3.colors > ~/.config/i3/config
fi


# wallpaper
if [ -d ~/.themes/$THEME/wallpapers/ ]; then
    feh --bg-fill --randomize ~/.themes/$THEME/wallpapers/*
fi


i3-msg reload
