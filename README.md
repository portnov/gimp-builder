gimp-builder readme
===================

# General description

This set of scripts is intended to ease building of GIMP from git master with
all it necessary dependencies on any Linux, without getting your system
littered with lots of development packages.

The scripts work by using docker to contain all build dependencies.
However, sources and built files for some dependencies (libmypaint, babl, gegl)
and GIMP itself will be located on your local filesystem, not inside the
container. This allows us to reuse already built files and thus, speed up build
process when you are building them for the second (third etc) time.

# Dependencies

To run this set of scripts, you will need:

* bash
* docker
* git

That's all.

# Usage

## Initializing your environment

First, you have to run

    $ ./configure

The script will ask you for paths in your filesystem, where you like to put
sources and built files for libmypaint, babl, gegl and GIMP.
If source directories which you specified already exist, then it will be
assumed that you already cloned corresponding repositories earlier:

* libmypaint: https://github.com/mypaint/libmypaint.git
* babl: git://git.gnome.org/babl
* gegl: git://git.gnome.org/gegl
* GIMP: git://git.gnome.org/gimp

If these directories do not exist, the script will clone these repositories
into that directories for you.

Also the script will ask you for directory where to save GIMP configuration
(~/.config/GIMP/2.9 by default), and a directory with files which you want to
be available for GIMP (your home directory by default). The last directory will
be seen as /data in GIMP open/save dialogs.

These directories will be saved into ~/.config/gimp-builder/paths file for
later usage.

## Building GIMP and its dependencies

To build, you have to run

    $ ./build-gimp.sh

The script will sometimes ask you, whether or not you want to run ./configure
for each of components (libmypaint, babl, gegl, GIMP). When you are building
for the first time, you have to answer "y" each time. For other times, you can
answer "n" to speed up building, or you may want to answer "y" if you think
that building environment and/or component sources changed condiderably for
some reason.

## Running GIMP

To run GIMP that you built, you just have to run

    $ ./run-gimp.sh

That's all!

# Additional info

Here is the description of other scripts included in distribution:

* clone.sh: this script is called from `configure' to clone dependencies
  repositories or check that someone did that before. You may want to run it by
  yourself to just clone all the set of sources.
* build-builder.sh: this is simple script which builds docker image with all
  GIMP build dependencies. The same command is invoked from build-gimp.sh.
* build-in-container.sh: this script is called inside docker container from
  build-gimp.sh. It calls the whole configure && make && make install stuff.

