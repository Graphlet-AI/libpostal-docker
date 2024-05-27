FROM continuumio/miniconda3:24.3.0-0

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

ENV POETRY_VIRTUALENVS_CREATE=false \
    POETRY_VERSION=1.8.3

# Install poetry so we can install our package requirements
WORKDIR /root
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH "/root/.local/bin:$PATH"

# Copy the poetry.lock and pyproject.toml files
COPY pyproject.toml poetry.lock /root/

RUN poetry config virtualenvs.create false && \
    poetry config installer.max-workers 10 && \
    poetry install --no-interaction --no-ansi --no-root -vvv && \
    poetry cache clear pypi --all -n

# Go into a holding pattern for the user to run address_parser or bash to try the Python library
CMD tail -f /dev/null
