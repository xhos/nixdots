#!/bin/bash

current_hour=$(date +"%H")

if [ "$current_hour" -ge 6 ] && [ "$current_hour" -lt 12 ]; then
    echo "Make yourself some coffee, $USER"
elif [ "$current_hour" -ge 12 ] && [ "$current_hour" -lt 20 ]; then
    echo "Try to be productive, $USER"
elif [ "$current_hour" -ge 20 ] && [ "$current_hour" -lt 23 ]; then
    echo "Relax, $USER"
else
    echo "Sleep well, $USER"
fi