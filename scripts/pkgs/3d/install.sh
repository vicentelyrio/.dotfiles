#!/usr/bin/env bash

set -e

# shellcheck source=/scripts/pkgs/3d/blender/install.sh
source "$(require "pkgs/3d/blender/install.sh")"

# shellcheck source=/scripts/pkgs/3d/cura/install.sh
source "$(require "pkgs/3d/cura/install.sh")"

# shellcheck source=/scripts/pkgs/3d/fusion3d/install.sh
source "$(require "pkgs/3d/fusion3d/install.sh")"

install3DExec () {
  local NAME="3D"

  printSection "Installing $NAME"

  install_blender
  install_cura
  install_fusion3d

  printSection "✓ $NAME successfully installed"
}

install3D() {
  printQuestion "3D"

  local ACTIONS

  local BLENDER="Blender"
  local CURA="Ultimaker Cura"
  local FUSION="Fusion 3D"

  ACTIONS=$(
    gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit \
    "$BLENDER" \
    "$CURA" \
    "$FUSION" \
  )

  case "$ACTIONS" in
    "$BLENDER") install_blender ;;
    "$CURA") install_cura ;;
    "$FUSION") install_fusion3d ;;
  esac
}
