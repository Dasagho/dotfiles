#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10
## style-11    style-12    style-13    style-14    style-15

# rofi -combi-modi "window,drun" -font "hack 16" -show combi -icon-theme "Adwaita" -show-icons -combi-display-format "{text}"

dir="$HOME/.config/rofi/launchers/type-1"
theme='style-1'

## Run
rofi \
    -combi-modi "window,drun" \
    -font "hack 16" \
    -show combi \
    -icon-theme "Adwaita" \
    -show-icons \
    -combi-display-format "{text}" \
    -theme ${dir}/${theme}.rasi
