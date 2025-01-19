#!/bin/bash

# Get the name of the currently focused monitor
FOCUSED_MONITOR=$(osascript -e 'tell application "System Events" to return name of current desktop')

# Get display information using system_profiler
DISPLAYS=$(system_profiler SPDisplaysDataType)

# Parse monitor details dynamically
FOCUSED_WIDTH=$(echo "$DISPLAYS" | grep -A2 "$FOCUSED_MONITOR" | grep "Resolution" | awk '{print $2}')
FOCUSED_HEIGHT=$(echo "$DISPLAYS" | grep -A2 "$FOCUSED_MONITOR" | grep "Resolution" | awk '{print $4}')
FOCUSED_OFFSET_X=$(echo "$DISPLAYS" | grep -A4 "$FOCUSED_MONITOR" | grep "Origin" | awk '{print $2}' | sed 's/[^0-9]//g')
FOCUSED_OFFSET_Y=$(echo "$DISPLAYS" | grep -A4 "$FOCUSED_MONITOR" | grep "Origin" | awk '{print $3}' | sed 's/[^0-9]//g')

# Fallback if parsing fails
FOCUSED_WIDTH=${FOCUSED_WIDTH:-1920}
FOCUSED_HEIGHT=${FOCUSED_HEIGHT:-1080}
FOCUSED_OFFSET_X=${FOCUSED_OFFSET_X:-0}
FOCUSED_OFFSET_Y=${FOCUSED_OFFSET_Y:-0}

# Calculate the center of the focused monitor
CENTER_X=$((FOCUSED_OFFSET_X + FOCUSED_WIDTH / 2))
CENTER_Y=$((FOCUSED_OFFSET_Y + FOCUSED_HEIGHT / 2))

# Move the mouse to the calculated position
osascript -e "tell application \"System Events\" to set mouse position to {${CENTER_X}, ${CENTER_Y}}"

