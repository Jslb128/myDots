#!/bin/bash

# Themes
text='#d8dee9'
red='#bf616a'
yellow='#ebcb8b'
blue='#88c0d0'
teal='#81a1c1'
green='#a3be8c'

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
bat=$(acpi | awk -F', ' '{print $2}')
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
"<span foreground='$yellow'>$date_formatted </span>"
