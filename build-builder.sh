#!/bin/bash

set -e

cd $(dirname $0)

if [ -f ~/.config/gimp-builder/paths ]
then . ~/.config/gimp-builder/paths
else ./configure
     . ~/.config/gimp-builder/paths
fi

# Check if newer debian image is available
docker pull debian:stretch

# Build image for building GIMP with all dependencies
docker build --build-arg LOCALE="$LOCALE" -t gimp-builder .

