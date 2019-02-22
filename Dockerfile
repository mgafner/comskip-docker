# Docker container for comskip
#
# This file is part of comskip-docker
# https://github.com/mgafner/comskip-docker
#
# This is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this file.  If not, see <http://www.gnu.org/licenses/>.
#
FROM ubuntu:16.04
ARG DEBIAN_FRONTEND="noninteractive"
ENV TERM="xterm" LANG="C.UTF-8" LC_ALL="C.UTF-8"
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      autoconf \
      build-essential \
      ffmpeg \ 
      git \
      libargtable2-dev \
      libavcodec-dev  \
      libavformat-dev \
      libavutil-dev \
      libsdl1.2-dev \
      libtool-bin \
      python3 \
      vim && \
#
# Clone comskip
    cd /opt && \
    git clone git://github.com/erikkaashoek/Comskip comskip && \
    cd comskip && \
    ./autogen.sh && \
    ./configure && \
    make && \
#
# Clone comchap/comcut
    cd /opt && \
    git clone https://github.com/mgafner/comchap.git && \
#
# link commands to user bin
    ln -s /opt/comskip/comskip /usr/bin/comskip && \
    ln -s /opt/comchap/comchap /usr/bin/comchap && \
    ln -s /opt/comchap/comcut /usr/bin/comcut && \
#
# Cleanup
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
#
ADD ./config/comskip.ini /root/.comskip.ini
