#!/bin/bash

cd $(dirname $0)

if [ -f ~/.config/gimp-builder/paths ]
then . ~/.config/gimp-builder/paths
else ./configure
     . ~/.config/gimp-builder/paths
fi

# Build image for building GIMP with all dependencies
docker build -t gimp-builder .

# Run the actual build inside the container.
docker run --rm -it \
  -v $LIBMYPAINT_SRC:/src/libmypaint \
  -v $GIMP_SRC:/src/gimp \
  -v $BABL_SRC:/src/babl \
  -v $GEGL_SRC:/src/gegl \
  -v $BUILD_DIR:/build \
  gimp-builder ./build-in-container.sh
