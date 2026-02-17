#!/usr/bin/env bash

SID="$1"

TEXT=0xffcdd6f4
SUBTEXT0=0xffa6adc8
BLUE=0xff89b4fa

if [ "$SID" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    icon.color=$TEXT \
    icon.highlight=on \
    background.drawing=on \
    background.height=3 \
    background.color=$BLUE \
    background.y_offset=-13
else
  sketchybar --set "$NAME" \
    icon.color=$SUBTEXT0 \
    icon.highlight=off \
    background.drawing=off
fi
