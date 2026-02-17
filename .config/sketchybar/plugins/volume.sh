#!/usr/bin/env bash

########################################
# Catppuccin Mocha Colors
########################################

TEXT=0xffcdd6f4
GREEN=0xffa6e3a1
YELLOW=0xfff9e2af
PEACH=0xfffab387
RED=0xfff38ba8
BLUE=0xff89b4fa
SUBTEXT0=0xffa6adc8

########################################
# Volume Change Event
########################################

if [ "$SENDER" = "volume_change" ]; then

  VOLUME="$INFO"

  ########################################
  # Icon + Color based on volume
  ########################################

  case "$VOLUME" in

    0)
      ICON="󰖁"
      COLOR=$SUBTEXT0
      ;;

    [1-2][0-9])
      ICON="󰕿"
      COLOR=$GREEN
      ;;

    [3-5][0-9])
      ICON="󰖀"
      COLOR=$GREEN
      ;;

    [6-9][0-9]|100)
      ICON="󰕾"
      COLOR=$GREEN
      ;;

    *)
      ICON="󰖁"
      COLOR=$TEXT
      ;;

  esac

  ########################################
  # Apply to SketchyBar
  ########################################

  sketchybar --set "$NAME" \
    icon="$ICON" \
    label="${VOLUME}%" \
    icon.color=$COLOR \
    label.color=$COLOR

fi
