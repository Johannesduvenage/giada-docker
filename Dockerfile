#-------------------------------------------------------------------------------
#
# Dockerfile to build Giada. Based on Debian Stable.
#
# Usage: 
# 	docker build --build-arg make_jobs=[n] -t giada .
#
#-------------------------------------------------------------------------------

FROM debian:stable-slim

LABEL maintainer="giadaloopmachine@gmail.com"
ARG make_jobs=1

# Install dependencies

RUN apt-get update && apt-get install -y \
	build-essential \
	gdb \
	autotools-dev \
	wget \
	autoconf \
	libtool \
	libx11-dev \
	libjack-dev \
	libasound2-dev \
	libxpm-dev \
	libfreetype6-dev \
	libxrandr-dev \
	libxinerama-dev \
	libxcursor-dev \
	libsndfile1-dev \
	libsamplerate0-dev \
	libfltk1.3-dev \
	libpulse-dev \
	libjansson-dev \
	libxft-dev \
&& rm -rf /var/lib/apt/lists/*

# TODO 
# temporary hack is useless, remove it
# make clean when done
# rm -rf rtmidi dir when done

# Download and install Rtmidi. Temporary hack: remove dynamic libs to force
# static linking.

WORKDIR /home/giada/deps

RUN wget http://www.music.mcgill.ca/~gary/rtmidi/release/rtmidi-3.0.0.tar.gz -O rtmidi-3.0.0.tar.gz && \
	tar zxfv rtmidi-3.0.0.tar.gz && rm rtmidi-3.0.0.tar.gz 

WORKDIR /home/giada/deps/rtmidi-3.0.0

RUN  ./configure --with-jack --with-alsa && make -j "$make_jobs" && make install && \
	rm /usr/local/lib/librtmidi.so /usr/local/lib/librtmidi.so.4 /usr/local/lib/librtmidi.so.4.0.0

WORKDIR /home/giada/build
