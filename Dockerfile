# Start from a Jupyter Docker Stacks version
# FROM continuumio/anaconda3:2024.02-1
FROM ubuntu:22.04

# Install system dependencies
RUN apt update && \
    apt upgrade -y && \
    apt install curl build-essential autoconf automake libtool pkg-config git -y && \
    rm -rf /var/lib/apt/lists/*

# Install Libpostal - a C library for parsing/normalizing street addresses around the world
RUN git clone https://github.com/openvenues/libpostal.git && \
    cd libpostal && \
    ./bootstrap.sh && \
    ./configure --datadir=/tmp --disable-sse2 MODEL=senzing && \
    make -j12 && \
    make install && \
    ldconfig

# Add libpostal executables to the PATH
ENV PATH "/libpostal/src:/libpostal/src/.libs:$PATH"

CMD tail -f /dev/null
