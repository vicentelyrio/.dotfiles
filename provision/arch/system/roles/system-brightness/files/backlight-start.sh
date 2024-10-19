#!/bin/bash

MONITORADDRESS=$(ddcutil detect --terse --sleep-multiplier 0 | grep bus | awk -F '/' '{print $3}')
echo 'ddcci 0x37' | sudo tee /sys/bus/i2c/devices/$MONITORADDRESS/new_device
