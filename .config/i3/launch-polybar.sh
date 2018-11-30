killall -q polybar

polybar -c ~/.config/i3/polybar monitor1 &
polybar -c ~/.config/i3/polybar monitor2 &
polybar -c ~/.config/i3/polybar monitor3 &

echo "Bars launched"
