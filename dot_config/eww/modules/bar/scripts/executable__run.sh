#!/bin/bash

EWW=`which eww`
CONFIG="$HOME/.config/eww/modules/bar"

if [[ ! `pidof eww` ]]; then
  ${EWW} daemon
  sleep 1
fi

run_eww() {
  echo "$CONFIG"
  if [ ! -z "$2" ]
  then
    ${EWW} --config "$CONFIG" "$1" "$2"
  else
    ${EWW} --config "$CONFIG" "$1"
  fi
}
