#!/bin/bash

set -x

LIBMYPAINT_SRC=/home/portnov/src/gimp/libmypaint
BABL_SRC=/home/portnov/src/gimp/babl
GEGL_SRC=/home/portnov/src/gimp/gegl
GIMP_SRC=/home/portnov/src/gimp
BUILD_DIR=/home/portnov/soft/gimp

docker run --rm -it \
  -v $LIBMYPAINT_SRC:/src/libmypaint \
  -v $GIMP_SRC:/src/gimp \
  -v $BABL_SRC:/src/babl \
  -v $GEGL_SRC:/src/gegl \
  -v $BUILD_DIR:/build \
  gimp-builder ./build.sh
