#!/bin/bash

DEVICE="FocalTechPS/2 FocalTech Touchpad"
STATE=$(xinput list-props "$DEVICE" | grep "Device Enabled" | cut -f3)

if [ $STATE == 1 ]; then
	xinput --disable "$DEVICE"
else
	xinput --enable "$DEVICE"
fi
