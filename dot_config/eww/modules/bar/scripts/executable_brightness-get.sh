#!/bin/sh

if command -v ddcutil &>/dev/null; then
  ddcutil getvcp 10 --terse | grep VCP | awk -F ' ' '{print$4}'
else
  40
fi

