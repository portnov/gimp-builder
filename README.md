gimp-builder readme
===================

# General description

This set of scripts is intended to ease building of GIMP from git master with
all it necessary dependencies on any Linux, without getting your system
littered with lots of development packages. The set of scripts is mainly
intended for GIMP enthusiasts, testers and other people who want to run the
very last version of GIMP.

The scripts work by using docker to contain build dependencies.  However,
sources and built files for dependencies that we build from source (libmypaint,
babl, gegl) and GIMP itself will be located on your local filesystem, not
inside the container. This allows us to reuse already built files and thus,
speed up build process when you are building them for the second (third etc)
time.

Note: GIMP built & installed by this set of scripts will not interfer with any
existing GIMP installation.

# Dependencies

To run this set of scripts, you will need:

* bash
* docker
* git

That's all.

# Usage

## Downloading scripts

There are options available, use whatever is more convinient for you:

* You can download [ZIP file](https://github.com/portnov/gimp-builder/archive/master.zip)
  and unzip it;
* Or you can clone this repository by running
    
    git clone https://github.com/portnov/gimp-builder.git


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

This script builds docker image with debian stretch and all GIMP build
dependencies. These dependencies include a lot of debian packages. If you want
to save your bandwidth when running this several times, you may run
apt-cacher-ng service on your machine. The script automatically checks if
apt-cacher is available on your host and uses it if possible.

The script will sometimes ask you, whether or not you want to run ./configure
for each of components (libmypaint, babl, gegl, GIMP). When you are building
for the first time, you have to answer "y" each time. For other times, you can
answer "n" to speed up building, or you may want to answer "y" if you think
that building environment and/or component sources changed considerably for
some reason.

The script does "git pull" by itself, so if you want to build last version of
GIMP and all its dependencies, you just need to run this script again.

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

