#!/usr/bin/env bash

SID="$1"

TEXT=0xffcdd6f4
MAUVE=0xffcba6f7

if [ "$SID" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    icon.color=$TEXT \
    icon.highlight=on \
    background.drawing=on \
    background.height=3 \
    background.color=$MAUVE \
    background.y_offset=-13
else
  sketchybar --set "$NAME" \
    icon.color=$TEXT \
    icon.highlight=off \
    background.drawing=off
fi
