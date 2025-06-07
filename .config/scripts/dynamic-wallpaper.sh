#!/bin/bash

HOUR=$(date +"%H")

if [ "$HOUR" -ge 6 ] && [ "$HOUR" -lt 12 ]; then
    WALLPAPER="$HOME/Bilder/DynamicBackground/morning.jpg"
elif [ "$HOUR" -ge 12 ] && [ "$HOUR" -lt 18 ]; then
    WALLPAPER="$HOME/Bilder/DynamicBackground/day.jpg"
elif [ "$HOUR" -ge 18 ] && [ "$HOUR" -lt 21 ]; then
    WALLPAPER="$HOME/Bilder/DynamicBackground/evening.jpg"
else
    WALLPAPER="$HOME/Bilder/DynamicBackground/night.jpg"
fi

gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER"