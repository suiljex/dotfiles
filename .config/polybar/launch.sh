#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar "main"
echo "---" | tee -a /tmp/polybar.log
polybar main 2>&1 | tee -a /tmp/polybar.log & disown

# Launch NetworkManager applet
nm-applet &

echo "Bars launched..."
