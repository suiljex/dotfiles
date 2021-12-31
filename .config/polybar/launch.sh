#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar "main"
echo "---" | tee -a /tmp/polybar_top.log /tmp/polybar_bottom.log
polybar top 2>&1 | tee -a /tmp/polybar_top.log & disown
polybar bottom 2>&1 | tee -a /tmp/polybar_bottom.log & disown

# Launch NetworkManager applet
#nm-applet &

# Remove gap
#bspc config top_padding 0
#bspc config bottom_padding 0

echo "Bars launched..."
