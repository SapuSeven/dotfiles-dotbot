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


# GTK theme
#sed -i "s/\(^gtk-theme-name=\).*/\1$THEME/"  ~/.config/gtk-3.0/settings.ini
#sed -i "s/\(^gtk-theme-name=\).*/\1$THEME/"  ~/.gtkrc-2.0
#gsettings set org.gnome.desktop.interface gtk-theme "$THEME"


# symlink current theme
ln -fnsd ~/.themes/$THEME ~/.themes/current


# reload
i3-msg reload
polybar-msg cmd restart

