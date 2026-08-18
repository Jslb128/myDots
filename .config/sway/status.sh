#!/bin/bash

# Themes
text='#c6d0f5'
red='#e78284'
yellow='#e5c890'
blue='#8caaee'
teal='#81c8be'
green='#a6d189'

# install acpi
date_formatted=$(date +'%d/%m/%Y %H:%M')

# Get audio info
aud_output=$(wpctl status | grep '\*.*playback' | grep -q 'Headphones' && echo 'Headphones' || echo 'Speakers')
vol=$(amixer get Master | awk -F"[][]" '/Left:/ {print $2}')
aud_status=$(amixer get Master | awk -F"[][]" '/Left:/ {print $4}')
aud_color=$text

# Get the Linux version
linux_version=$(uname -r | cut -d '-' -f1)

# Get battery info
bat=$(acpi -b | awk -F', ' '{print $2}')
bun=$(brightnessctl -m | cut -d ',' -f4)
bat_status=$(acpi -b | awk -F' ' '{print $3}' | cut -b 1)
bat_color=$red

if [ $bat_status == "C" ]; then
	bat_color=$green
else
	bat_color=$red
fi
if [ $aud_status == "on" ]; then
	aud_color=$green
else
	aud_color=$red
fi
# Load status bar

echo \
"<span foreground='$text'>$linux_version</span>" \
"<span foreground='$text'>|</span>" \
\
"<span foreground='$aud_color'>($aud_output)</span>" \
"<span foreground='$text'>vol:</span>" \
"<span foreground='$teal'>$vol</span>" \
\
"<span foreground='$text'>sun:</span>" \
"<span foreground='$teal'>$bun</span>" \
\
"<span foreground='$text'>bat:</span>" \
"<span foreground='$teal'>$bat</span>" \
"<span foreground='$bat_color'>$bat_status</span>" \
\
"<span foreground='$text'>|</span>" \
"<span foreground='$text'>$date_formatted </span>"
