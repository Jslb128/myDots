#!/bin/bash

currentSink=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | grep node.nick | awk -F'"' '{print $2}')
sID=56
hID=55
if [ "$currentSink" == "Speaker playback" ]; then
	wpctl set-default $hID
else 
	wpctl set-default $sID
fi