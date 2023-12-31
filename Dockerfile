#FROM ubuntu:18.04
FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
    make \
    cmake \
    curl \
    gcc \
    git \
    tmux \
    htop \
    nano \
    python3.7 \
    python3-pip \
    libglu1-mesa-dev \
    libgl1-mesa-dev \
    libgl1-mesa-glx \
    libosmesa6-dev \
    xvfb \
    ffmpeg \
    curl \
    patchelf \
    libglfw3 \
    libglfw3-dev \
    zlib1g \
    zlib1g-dev \
    swig \
    wget \
    build-essential \
    zlib1g-dev \
    libsdl2-dev \
    libjpeg-dev \
    nasm \
    tar \
    libbz2-dev \
    libgtk2.0-dev \
    libfluidsynth-dev \
    libgme-dev \
    libopenal-dev \
    libboost-all-dev \
    timidity \
    libwildmidi-dev \
    unzip \
    lsof \
    libjpeg-turbo8-dev \
    xorg-dev \
    libx11-dev \
    libxcursor-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxi-dev \
    libxxf86vm-dev \
    mesa-common-dev

RUN python3.7 -m pip install --upgrade pip

COPY requirement.txt /tmp/
RUN pip3.7 install --upgrade pip
RUN pip3.7 install -r /tmp/requirement.txt 
RUN rm /tmp/requirement.txt
RUN rm /usr/bin/python && ln -s /usr/bin/python3.7 /usr/bin/python

ENV PYTHONPATH /code

WORKDIR /code
