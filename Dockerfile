FROM debian:stretch
MAINTAINER Ilya Portnov <portnov@iportnov.ru>

# Use apt-cacher-ng proxy if it is enabled on docker host
RUN export HOST=$(ip route | awk '/default/ {print $3}') && \
    if timeout 1 bash -c "cat < /dev/null > /dev/tcp/$HOST/3142"; \
    then echo "Acquire::http { Proxy \"http://$HOST:3142\"; };" >> /etc/apt/apt.conf.d/01proxy; \
         echo Using APT proxy at $HOST; \
    else echo APT proxy is not available, skipping; \
    fi

# Install GIMP build dependencies
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
      librsvg2-dev libgs-dev locales

ARG LOCALE

RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen && \
    echo $LOCALE >> /etc/locale.gen && \
    locale-gen

RUN mkdir -p /src/babl && mkdir -p /src/gegl && mkdir -p /src/gimp && mkdir -p /src/libmypaint && mkdir /build && mkdir /data

VOLUME /src/babl
VOLUME /src/gegl
VOLUME /src/gimp
VOLUME /src/libmypaint
VOLUME /build
VOLUME /data
VOLUME /root/.config/GIMP/2.9

ADD build-in-container.sh /
