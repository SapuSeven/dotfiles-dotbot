#!/bin/sh

fgColor=#ffb52a
bgColor=#222222
logoSize=300


mkdir .tmp

# Foreground
magick convert -background none logo.svg -fill $fgColor -colorize 100 -scale $logoSize .tmp/logo.png


# Combine
magick convert -size 1920x1080 xc:$bgColor .tmp/logo.png -depth 8 -gravity center -composite bg.png


rm -r .tmp
