# 
# This is a Dockerfile for L4T-DEV-BASE
#

FROM ierturk/l4t-base:latest

ARG DEBIAN_FRONTEND=noninteractive

USER root

#
# Build tools
#

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    gcc-8 g++-8 \
    cmake git unzip pkg-config ninja-build \
    wget curl rsync \
    python3-dev python3-pip python3-numpy \
    cuda-toolkit-10-2 nvidia-cudnn8 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Required for cuda compiler
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8

# OpenCV looks for the cuDNN version in cudnn_version.h, but it's been renamed to cudnn_version_v8.h
RUN ln -s /usr/include/aarch64-linux-gnu/cudnn_version_v8.h /usr/include/aarch64-linux-gnu/cudnn_version.h

# Set as default user
USER ierturk
WORKDIR /home/ierturk

CMD ["bash"]
