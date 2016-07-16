FROM debian:stretch
MAINTAINER Ilya Portnov <portnov@iportnov.ru>

RUN export HOST=$(ip route | awk '/default/ {print $3}') && \
    echo "Acquire::http { Proxy \"http://$HOST:3142\"; };" >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update && \
    apt-get install -y build-essential git \
      sgml-base libjson-c-dev libtool autoconf \
      automake intltool libgtk2.0-dev \
      libjson-glib-dev libjpeg-dev libtiff5-dev \
      gtk-doc-tools xsltproc && \
    apt-get install -y libgexiv2-dev libbz2-dev python-dev \
      python-gtk2-dev python-cairo-dev libharfbuzz-dev \
      libfreetype6-dev zlib1g-dev liblzma-dev libpng-dev \
      libpoppler-dev libpoppler-glib-dev poppler-data libjasper-dev \
      librsvg2-dev libgs-dev

RUN mkdir -p /src/babl && mkdir -p /src/gegl && mkdir -p /src/gimp && mkdir -p /src/libmypaint && mkdir /build && mkdir /data

VOLUME /src/babl
VOLUME /src/gegl
VOLUME /src/gimp
VOLUME /src/libmypaint
VOLUME /build
VOLUME /data

ADD build.sh /
