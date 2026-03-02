#!/usr/bin/env bash
set -euo pipefail

NIGHTSCOUT_URL="https://nightscout.mantannest.com"

# Color thresholds
GREEN=0xffa6e3a1
PEACH=0xfffab387
RED=0xfff38ba8
STALE=0xffa6adc8

API="${NIGHTSCOUT_URL%/}/api/v1/entries.json?count=1"

json="$(curl -fsS --max-time 5 "$API" || true)"

if [[ -z "${json}" || "${json}" == "null" ]]; then
  sketchybar --set "$NAME" label="--"
  exit 0
fi

sgv="$(jq -r '.[0].sgv // empty' <<<"$json")"
direction="$(jq -r '.[0].direction // empty' <<<"$json")"

dateString="$(jq -r '.[0].dateString // empty' <<<"$json")"
dateMsRaw="$(jq -r '.[0].date // empty' <<<"$json")"

# Trend arrow
arrow="•"
case "$direction" in
  Flat) arrow="→" ;;
  FortyFiveUp) arrow="↗" ;;
  SingleUp) arrow="↑" ;;
  DoubleUp) arrow="↑↑" ;;
  FortyFiveDown) arrow="↘" ;;
  SingleDown) arrow="↓" ;;
  DoubleDown) arrow="↓↓" ;;
  *) arrow="•" ;;
esac

now_epoch="$(date -u +%s)"
entry_epoch=""

if [[ -n "${dateString:-}" && "$dateString" != "null" ]]; then
  entry_epoch="$(date -j -u -f "%Y-%m-%dT%H:%M:%S.000Z" "$dateString" +%s 2>/dev/null || true)"
fi

if [[ -z "$entry_epoch" && -n "${dateMsRaw:-}" && "$dateMsRaw" != "null" ]]; then
  dateMsInt="${dateMsRaw%%.*}"
  if [[ "$dateMsInt" =~ ^[0-9]+$ ]]; then
    entry_epoch="$((dateMsInt / 1000))"
  fi
fi

age_min="?"
if [[ -n "$entry_epoch" ]]; then
  diff="$((now_epoch - entry_epoch))"
  (( diff < 0 )) && diff=0
  age_min="$((diff / 60))"
fi

if [[ -z "${sgv:-}" || "$sgv" == "null" ]]; then
  sketchybar --set "$NAME" label="--"
  exit 0
fi

label="${sgv} ${arrow} ${age_min}m"

########################################
# Color Logic
########################################

color="$PEACH"  # default

if (( sgv >= 80 && sgv <= 110 )); then
  color="$GREEN"
elif (( sgv < 60 || sgv >= 180 )); then
  color="$RED"
else
  color="$PEACH"
fi

# If stale (>=15m), override with muted color
if [[ "$age_min" != "?" && "$age_min" -ge 15 ]]; then
  color="$STALE"
fi

sketchybar --set "$NAME" label="$label" label.color="$color" icon.color="$color"
