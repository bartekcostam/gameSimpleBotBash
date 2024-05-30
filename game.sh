#!/bin/bash

# Coordinates for the mouse clicks
left_click_x=3345
left_click_y=1773
right_click_x=2358
right_click_y=1871

collect_click_x=3103
collect_click_y=2042

# Interval between clicks in seconds
interval=5

hold_duration=1.5

left_click() {
  xdotool mousemove $left_click_x $left_click_y click 1
}

collect_click() {
  xdotool mousemove $collect_click_x $collect_click_y click 1
}

# Function to perform a right click
right_click() {
  xdotool mousemove $right_click_x $right_click_y click 3
}

# Function to press and hold left click for a specified duration
left_click_hold() {
  xdotool mousemove $left_click_x $left_click_y mousedown 1
  sleep "$hold_duration"
  xdotool mouseup 1
}

right_click_hold() {
  xdotool mousemove $right_click_x $right_click_y mousedown 3
  sleep "$hold_duration"
  xdotool mouseup 3
}

# Function to collect items at specified coordinates
collect_items() {
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
    sleep 1  # Adjust sleep time as necessary to ensure the click is registered
  done
}

# Trap custom signal (SIGUSR1) to exit the script
trap "echo 'Script terminated by Shift + Space'; exit" SIGUSR1

# Inform the user how to exit
echo "Press Shift + Space to terminate the script."

new_game() {
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

combo() {
  x=3357
  y=1852
  xdotool mousemove $x $y click 1
}
# Loop to perform clicks indefinitely
while true; do
  sleep "$interval"
  
  right_click_hold
  combo
  left_click

  right_click_hold
  
  left_click
    combo
  right_click_hold

  left_click
  right_click_hold
  combo
combo
  left_click

  right_click_hold

  left_click
  right_click_hold
  combo
  left_click

  right_click_hold
combo
combo
  left_click
  
 
  combo
combo
  right_click_hold
  left_click
collect_items
  right_click_hold
  combo
  combo
  left_click

  right_click_hold

  left_click
  right_click_hold
  
  left_click
combo
combo
  right_click_hold

  left_click
  right_click_hold
  combo
  left_click

  right_click_hold

  left_click
  
 collect_items
  combo
  combo
  
   right_click_hold
  left_clickc
combo
combo
  right_click_hold
  
  left_click
combo
combo
  right_click_hold

  left_click
  right_click_hold
  
  left_click

  right_click_hold

  left_click
  right_click_hold
  combo
combo
  left_click

  right_click_hold

  left_click
  combo
  combo
 
 collect_items
   right_click_hold
  left_click
combo
combo
  right_click_hold
  
  left_click

  right_click_hold
combo
combo
  left_click
  right_click_hold
  
  left_click

  right_click_hold
combo
combo
  left_click
  right_click_hold
  
  left_click

  right_click_hold
combo
combo
  left_click
  
 
 collect_items
   right_click_hold
  combo
combo
    new_game
     new_game
     new_game
  
done