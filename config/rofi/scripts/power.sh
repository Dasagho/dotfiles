#!/usr/bin/env bash

# Power menu options
options="? Shutdown\n?? Restart\n?? Sleep\n?? Lock\n?? Hibernate\n?? Logout"

# Show rofi menu and get choice
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -theme ~/.config/rofi/themes/power.rasi)

# Execute based on choice
case $chosen in
  "? Shutdown")
    systemctl poweroff
    ;;
  "?? Restart")
    systemctl reboot
    ;;
  "?? Sleep")
    systemctl suspend
    ;;
  "?? Lock")
    # Change this to your lock command (i3lock, swaylock, etc.)
    i3lock -c 000000
    ;;
  "?? Hibernate")
    systemctl hibernate
    ;;
  "?? Logout")
    # Change this based on your window manager/desktop environment
    # For i3: i3-msg exit
    # For sway: swaymsg exit
    # For GNOME: gnome-session-quit
    # For KDE: qdbus org.kde.ksmserver /KSMServer logout 1 3 3
    i3-msg exit
    ;;
esac
