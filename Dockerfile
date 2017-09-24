#-------------------------------------------------------------------------------
#
# Dockerfile to build Giada. Based on Debian Stable.
#
# Usage: 
# 	docker build --build-arg make_jobs=[n] -t giada .
#
#-------------------------------------------------------------------------------


FROM debian:stable
LABEL maintainer="giadaloopmachine@gmail.com"
# --build-arg make_jobs=[n]
ARG make_jobs=1

RUN apt-get update && apt-get install -y \
	build-essential \
	autotools-dev \
	wget \
	autoconf \
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

# Download and install Rtmidi

WORKDIR /home/giada/deps

RUN wget http://www.music.mcgill.ca/~gary/rtmidi/release/rtmidi-3.0.0.tar.gz -O rtmidi-3.0.0.tar.gz && \
	tar zxfv rtmidi-3.0.0.tar.gz && rm rtmidi-3.0.0.tar.gz

WORKDIR /home/giada/deps/rtmidi-3.0.0

RUN  ./configure --with-jack --with-alsa && make -j "$make_jobs" && make install

WORKDIR /home/giada/build
