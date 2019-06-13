#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
xrdb ~/.Xresources
xmodmap ~/.xmodmaprc
xset b off
xsetwacom --set `xsetwacom --list devices | grep STYLUS | sed 's/.*id: \([0-9]*\).*/\1/g'` mode relative
pulseaudio --start
# feh --bg-fill -z /home/charlieb/.config/awesome/themes/images
#exec wmii
#exec awesome
#exec startfluxbox
#exec fvwm2
#exec dwm
#exec ~/src/stumpwm/stumpwm
#exec musca
#exec scrotwm
#exec enlightenment_start
#exec openbox-session
#exec fluxbox
#exec i3
#exec notion
exec gnome-session

