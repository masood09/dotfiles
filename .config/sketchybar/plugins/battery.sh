#!/usr/bin/env bash

########################################
# Catppuccin Mocha Colors
########################################

GREEN=0xffa6e3a1
YELLOW=0xfff9e2af
PEACH=0xfffab387
RED=0xfff38ba8

########################################
# Get battery info
########################################

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

########################################
# Icon based on percentage
########################################

case "$PERCENTAGE" in
  9[0-9]|100)
    ICON=""
    COLOR=$GREEN
    ;;
  [6-8][0-9])
    ICON=""
    COLOR=$GREEN
    ;;
  [4-5][0-9])
    ICON=""
    COLOR=$YELLOW
    ;;
  [2-3][0-9])
    ICON=""
    COLOR=$PEACH
    ;;
  *)
    ICON=""
    COLOR=$RED
    ;;
esac

########################################
# Charging override
########################################

if [ -n "$CHARGING" ]; then
  ICON=""
  COLOR=$GREEN
fi

########################################
# Apply to SketchyBar
########################################

sketchybar --set "$NAME" \
  icon="$ICON" \
  label="${PERCENTAGE}%" \
  icon.color=$COLOR \
  label.color=$COLOR
