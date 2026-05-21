#!/usr/bin/env bash
exec "$(dirname "$(readlink -f "$0")")/adjust.sh" -10
