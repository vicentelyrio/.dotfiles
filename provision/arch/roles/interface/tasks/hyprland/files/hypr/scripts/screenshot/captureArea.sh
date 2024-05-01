#!/bin/bash

grim -g "$(slurp)" $HOME/Downloads/Screnshot-$(date +'%s.png')

paplay $HOME/.config/hypr/assets/audio/camera-shutter.ogg
