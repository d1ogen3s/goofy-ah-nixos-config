#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

SELECTED=$(ls "$WALLPAPER_DIR" | rofi -dmenu -p "Select Wallpaper" -i)

if [ -n "$SELECTED" ]; then
    IMAGE_PATH="$WALLPAPER_DIR/$SELECTED"

    awww img "$IMAGE_PATH" --transition-type center

fi
