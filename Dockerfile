#-------------------------------------------------------------------------------
#
# Dockerfile to build Giada. Based on Debian Stable.
#
# Usage: 
# 	docker build --build-arg make_jobs=[n] -t giada .
#
#-------------------------------------------------------------------------------

FROM debian:buster-slim

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
	librtmidi-dev \
	libpulse-dev \
	libjansson-dev \
	libxft-dev \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /home/giada/build
