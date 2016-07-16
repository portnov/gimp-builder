#!/bin/bash

set -e

cd $(dirname $0)

if hash git 2>/dev/null
then echo git is available, ok...
else echo You have to install git first.
     exit 1
fi

if [ -f ~/.config/gimp-builder/paths ]
then . ~/.config/gimp-builder/paths
else ./configure
     . ~/.config/gimp-builder/paths
fi

if [ -d $LIBMYPAINT_SRC ]
then echo libmypaint source directory already exists, assuming you cloned this repo earlier.
else echo libmypaint source directory does not exist yet, creating clone for you...
     mkdir -p $LIBMYPAINT_SRC
     git clone https://github.com/mypaint/libmypaint.git $LIBMYPAINT_SRC
fi

if [ -d $BABL_SRC ]
then echo babl source directory already exists, assuming you cloned this repo earlier.
else echo babl source directory does not exist yet, creating clone for you...
     mkdir -p $BABL_SRC
     git clone git://git.gnome.org/babl $BABL_SRC
fi

if [ -d $GEGL_SRC ]
then echo gegl source directory already exists, assuming you cloned this repo earlier.
else echo gegl source directory does not exist yet, creating clone for you...
     mkdir -p $GEGL_SRC
     git clone git://git.gnome.org/gegl $GEGL_SRC
fi

if [ -d $GIMP_SRC ]
then echo GIMP source directory already exists, assuming you cloned this repo earlier.
else echo GIMP source directory does not exist yet, creating clone for you...
     mkdir -p $GIMP_SRC
     git clone git://git.gnome.org/gimp
fi

echo done cloning dependencies.

