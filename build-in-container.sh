#!/bin/bash

set -e

export INSTALL_PREFIX=/build
export PATH=$INSTALL_PREFIX/bin:$PATH
export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=$INSTALL_PREFIX/lib:$LD_LIBRARY_PATH

echo .
echo Building libmypaint...
cd /src/libmypaint
read -p "Run configure y/[n]? " RUN_CONFIGURE
if [ $RUN_CONFIGURE = y ]
then ./autogen.sh
     ./configure --prefix=$INSTALL_PREFIX
fi
make -j4
make install

echo .
echo Building babl...
cd /src/babl
git pull
read -p "Run configure y/[n]? " RUN_CONFIGURE
if [ $RUN_CONFIGURE = y ]
then ./autogen.sh --prefix=$INSTALL_PREFIX
fi
make -j4
make install

echo .
echo Building gegl...
cd /src/gegl
git pull
read -p "Run configure y/[n]? " RUN_CONFIGURE
if [ $RUN_CONFIGURE = y ]
then ./autogen.sh --prefix=$INSTALL_PREFIX
fi
make -j4
make install

echo .
echo Building GIMP...
cd /src/gimp
git pull
read -p "Run configure y/[n]? " RUN_CONFIGURE
if [ $RUN_CONFIGURE = y ]
then ./autogen.sh --prefix=$INSTALL_PREFIX
fi
make -j4
make install

