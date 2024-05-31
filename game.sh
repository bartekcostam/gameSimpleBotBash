#!/bin/bash

# Coordinates for the mouse clicks
left_click_x=3345
left_click_y=1773
right_click_x=2358
left_click_y=1871

collect_click_x=3103
collect_click_y=2042

# Coordinates for key-triggered clicks
x_key_click_x=2340
x_key_click_y=1774
v_key_click_x=2696
v_key_click_y=2169

# Interval between clicks in seconds
interval=1
# Duration to hold the click in seconds
hold_duration=1.5
# Interval to run combo function in seconds
combo_interval=0.5

# Flag to pause main loop when 'x' is pressed
pause_main_loop=false

# Function to perform a left click
left_click() {
  echo "Performing left click"
  xdotool mousemove $left_click_x $left_click_y click 1
}

# Function to collect click
collect_click() {
  echo "Performing collect click"
  xdotool mousemove $collect_click_x $collect_click_y click 1
}

# Function to perform a right click
right_click() {
  echo "Performing right click"
  xdotool mousemove $right_click_x $right_click_y click 3
}

# Function to press and hold left click for a specified duration
left_click_hold() {
  echo "Performing left click hold"
  xdotool mousemove $left_click_x $left_click_y mousedown 1
  sleep "$hold_duration"
  xdotool mouseup 1
}

# Function to press and hold right click for a specified duration
right_click_hold() {
  echo "Performing right click hold"
  xdotool mousemove $right_click_x $right_click_y mousedown 3
  sleep "$hold_duration"
  xdotool mouseup 3
}

# Function to collect items at specified coordinates faster
collect_items() {
  echo "Collecting items"
  local coordinates=(
    "2984 2052"
    "3044 2058"
    "3129 2050"
    "3159 2044"
    "3139 2030"
    "2839 2030"
    "2819 2050"
  )

  for coord in "${coordinates[@]}"; do
    x=$(echo $coord | cut -d ' ' -f 1)
    y=$(echo $coord | cut -d ' ' -f 2)
    xdotool mousemove $x $y click 1
    sleep 0.1  # Reduced sleep time to speed up item collection
  done
}

# Function to start a new game by pressing buttons at specified coordinates
new_game() {
  echo "Starting a new game"
  local game_coordinates=(
    "2858 2017"
    "3170 2013"
  )

  for coord in "${game_coordinates[@]}"; do
    x=$(echo $coord | cut -d ' ' -f 1)
    y=$(echo $coord | cut -d ' ' -f 2)
    xdotool mousemove $x $y click 1
    sleep 1  # 1 second sleep between actions
  done
}

# Function to double click a button at the specified coordinates for a combo action
combo() {
  echo "Performing combo action"
  x=3357
  y=1852
  xdotool mousemove $x $y click 1
  sleep 0.1
  xdotool click 1
}

# Function to handle key presses
key_listener() {
  sudo evtest "/dev/input/event9" | while read -r line; do
    if [[ $line == *"EV_KEY"* ]]; then
      keycode=$(echo "$line" | grep -oP '(?<=code )\d+')
      value=$(echo "$line" | grep -oP '(?<=value )\d+')
      echo "Keycode: $keycode, Value: $value"  # Debugging output
      if [[ $keycode == "45" && $value == "1" ]]; then  # Key 'x' pressed
        echo "Key 'x' pressed, holding left click at ($x_key_click_x, $x_key_click_y)"
        pause_main_loop=true
        xdotool mousemove $x_key_click_x $x_key_click_y mousedown 1
      elif [[ $keycode == "45" && $value == "0" ]]; then  # Key 'x' released
        echo "Key 'x' released"
        xdotool mouseup 1
        pause_main_loop=false
      elif [[ $keycode == "47" && $value == "1" ]]; then  # Key 'v' pressed
        echo "Key 'v' pressed, holding left click at ($v_key_click_x, $v_key_click_y)"
        xdotool mousemove $v_key_click_x $v_key_click_y click 1
      fi
    fi
  done
}

# Trap custom signal (SIGUSR1) to exit the script
trap "echo 'Script terminated by Shift + Space'; exit" SIGUSR1

# Inform the user how to exit
echo "Press Shift + Space to terminate the script."

# Variables to keep track of time
last_combo_time=$(date +%s)

# Start the key listener function in the background
key_listener &

# Loop to perform clicks indefinitely
while true; do
  # Pause the main loop if 'x' is pressed
  while [ "$pause_main_loop" = true ]; do
    sleep 0.1
  done

  current_time=$(date +%s)

  # Perform the main sequence of clicks
  sleep "$interval"
  
  # Ensure left_click is immediately followed by right_click_hold
  echo "Performing action sequence"
  left_click
  
  combo
  right_click_hold
  combo
  
  left_click
   
  right_click_hold
  
  left_click
  left_click
  right_click_hold
  
  left_click
  combo
  right_click_hold
  
  left_click
  right_click_hold
  
  left_click
  right_click_hold
  combo
  left_click
  right_click_hold
  
  left_click
  right_click_hold
  
  collect_items
  combo
  left_click
  right_click_hold
  
  left_click
  right_click_hold
  combo
  left_click
  right_click_hold
  
  left_click
  right_click_hold
  
  collect_items
  
  left_click
  right_click_hold
  combo
  collect_items
  
  left_click

  left_click
  right_click_hold
  combo
  collect_click
  left_click
  right_click_hold
  
  collect_items
  combo
  left_click
  right_click_hold
  
  collect_click
  left_click
  right_click_hold
  combo
  collect_items
  combo
  left_click
  right_click_hold
  combo
  collect_click
  left_click
  right_click_hold
  combo
  collect_items
  
  left_click
  right_click_hold
  
  collect_click
  left_click
  right_click_hold
  combo
  collect_items
  combo
  left_click
  right_click_hold
  combo
  collect_click
  left_click
  right_click_hold
  
  collect_items
  
  left_click
  right_click_hold
  combo
  collect_click
  combo
  left_click
  right_click_hold
  combo
  collect_click
  left_click
  right_click_hold
  
  collect_items
  
  left_click
  right_click_hold
  combo
  collect_click
  # Run new_game function
  new_game
  
  time_diff=$(echo "$current_time - $last_combo_time" | bc)
  if (( $(echo "$time_diff >= $combo_interval" | bc -l) )); then
    combo
    last_combo_time=$current_time
  fi
  
done
