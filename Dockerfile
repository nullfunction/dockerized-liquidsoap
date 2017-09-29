FROM debian:stable-slim

# Set up dependenciess
RUN apt-get -y update && \
  apt-get -y install \
    build-essential \
    wget \
    curl \
    telnet \
    libmad0-dev \
    libshout3-dev \
    libvorbis-dev \
    libid3tag0-dev \
    libmad0-dev \
    libshout3-dev \
    libasound2-dev \
    libpcre3-dev \
    libmp3lame-dev \
    libogg-dev \
    libtag1-dev \
    libssl-dev \
    libtool \
    libflac-dev \
    libogg-dev \
    libsamplerate-dev \
    libavutil-dev \
    libopus-dev \
    autotools-dev \
    autoconf \
    automake \
    ocaml-nox \
    opam \
    m4

# Set up filesystem
USER root

RUN mkdir /var/log/liquidsoap
RUN chown -R liquidsoap:liquidsoap /var/log/liquidsoap
RUN chmod 766 /var/log/liquidsoap

RUN mkdir /etc/liquidsoap && mkdir /etc/liquidsoap/includes && chmod -R 755 /etc/liquidsoap

# Create the Liquidsoap user
RUN useradd -m liquidsoap
USER liquidsoap

# Initialize OPAM and install Liquidsoap and asssociated packages
RUN echo n | opam init
RUN opam update
RUN eval `opam config env`
RUN echo y | opam install ssl opus cry flac inotify lame mad ogg samplerate taglib vorbis xmlplaylist liquidsoap

# We'll start Liquidsoap with a default file, which must be provided on container start
ENTRYPOINT ["/home/liquidsoap/.opam/system/bin/liquidsoap", "/etc/liquidsoap/liquidsoap.liq"]