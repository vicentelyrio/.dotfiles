#!/bin/bash

echo "$(hyprctl activeworkspace | grep 'workspace ID' | awk '{print$3}')"
