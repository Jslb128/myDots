#!/bin/bash

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"

Ulimit=80
Llimit=25
bat=$(acpi -b | awk '{print $4}' | tr -d '%,')
bat_status=$(acpi -b |  awk '{print $3}' | tr -d ',')
if [[ "$bat_status" == "Charging" && "$bat" > "$Ulimit" ]]; then
    notify-send -u normal 'Bat' 'Battery > 80 you can unplug the charger'
elif [[ "$bat_status" == "Discharging" && "$bat" < "$Llimit" ]]; then
    notify-send -u critical 'Bat' 'Battery < 25 plug in the charger'
fi