#!/bin/sh

if command -v ddcutil &>/dev/null; then
  brightness=$(ddcutil getvcp 10 --terse | grep VCP | awk -F ' ' '{print$4}')

  if (( brightness <= 10 )); then
    echo "󱩎"
  elif (( brightness <= 20 )); then
    echo "󱩏"
  elif (( brightness <= 30 )); then
    echo "󱩐"
  elif (( brightness <= 40 )); then
    echo "󱩑"
  elif (( brightness <= 50 )); then
    echo "󱩒"
  elif (( brightness <= 60 )); then
    echo "󱩓"
  elif (( brightness <= 70 )); then
    echo "󱩔"
  elif (( brightness <= 80 )); then
    echo "󱩕"
  elif (( brightness <= 90 )); then
    echo "󱩖"
  else
    echo "󰛨"
  fi
fi

