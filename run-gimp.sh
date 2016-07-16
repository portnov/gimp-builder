#!/bin/bash

set -x

BUILD_DIR=/home/portnov/soft/gimp

xhost +local:

docker run --rm -it \
  -v $BUILD_DIR:/build \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /home/portnov:/data \
  -e DISPLAY=unix$DISPLAY \
  gimp-builder /build/bin/gimp-2.9
