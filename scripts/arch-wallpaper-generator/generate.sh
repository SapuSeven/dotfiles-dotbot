#!/bin/sh

fgColor=#ffb52a
bgColor=#222222
logoName=arch
logoSize=300

# Customize the settings above in generate.conf

cd "$(dirname "${BASH_SOURCE[0]}")"

test -f ./generate.conf && source ./generate.conf

mkdir .tmp

# Foreground
magick convert -background none -density 500 logo-$logoName.svg -fill $fgColor -colorize 100 -scale $logoSize .tmp/logo-$logoName.png


# Combine
magick convert -size 1920x1080 xc:$bgColor .tmp/logo-$logoName.png -depth 8 -gravity center -composite bg.png


rm -r .tmp
