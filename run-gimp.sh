#!/bin/bash

cd $(dirname $0)

if [ -f ~/.config/gimp-builder/paths ]
then . ~/.config/gimp-builder/paths
else ./configure
     . ~/.config/gimp-builder/paths
fi

xhost +local:

docker run --rm -it \
  -v $BUILD_DIR:/build \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $GIMP_DATA_DIR:/data \
  -v $GIMP_CFG_DIR:/root/.config/GIMP/2.9 \
  -e DISPLAY=unix$DISPLAY \
  gimp-builder /build/bin/gimp-2.9
