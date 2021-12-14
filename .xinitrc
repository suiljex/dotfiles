#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle

#exec dbus-launch --exit-with-x11 bspwm
#dbus-start-session bspwm
exec bspwm
