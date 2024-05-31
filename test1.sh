#!/bin/bash

# Coordinates for key-triggered clicks
x_key_click_x=2340
x_key_click_y=1774
v_key_click_x=2696
v_key_click_y=2169

# Identify your keyboard event device
keyboard_event_device="/dev/input/event9"  # Replace with your actual event number

if [ ! -e "$keyboard_event_device" ]; then
  echo "Error: Device $keyboard_event_device does not exist."
  exit 1
fi

echo "Listening for 'x' and 'v' key presses. Press 'Ctrl+C' to quit."

sudo evtest "$keyboard_event_device" | while read -r line; do
  echo "Raw line: $line"  # Debugging output
  if [[ $line == *"EV_KEY"* ]]; then
    keycode=$(echo "$line" | grep -oP '(?<=code )\d+')
    value=$(echo "$line" | grep -oP '(?<=value )\d+')
    echo "Keycode: $keycode, Value: $value"  # Debugging output
    if [[ $keycode == "45" && $value == "1" ]]; then  # Key 'x' pressed
      echo "Key 'x' pressed, holding left click at ($x_key_click_x, $x_key_click_y)"
      xdotool mousemove $x_key_click_x $x_key_click_y mousedown 1
      if [ $? -ne 0 ]; then echo "Error executing xdotool command for x"; fi
    elif [[ $keycode == "45" && $value == "0" ]]; then  # Key 'x' released
      echo "Key 'x' released"
      xdotool mouseup 1
      if [ $? -ne 0 ]; then echo "Error executing xdotool command for x release"; fi
    elif [[ $keycode == "47" && $value == "1" ]]; then  # Key 'v' pressed
      echo "Key 'v' pressed, holding left click at ($v_key_click_x, $v_key_click_y)"
      xdotool mousemove $v_key_click_x $v_key_click_y mousedown 1
      if [ $? -ne 0 ]; then echo "Error executing xdotool command for v"; fi
    elif [[ $keycode == "47" && $value == "0" ]]; then  # Key 'v' released
      echo "Key 'v' released"
      xdotool mouseup 1
      if [ $? -ne 0 ]; then echo "Error executing xdotool command for v release"; fi
    fi
  fi
done
